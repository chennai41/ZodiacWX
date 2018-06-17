/*
 * Support for Northbound Networks Zodiac WX
 *
 * Copyright (C) 2017 Paul Zanna <paul@northboundnetwork.com>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 as published
 * by the Free Software Foundation.
 */

#include <linux/phy.h>
#include <linux/gpio.h>
#include <linux/ar8216_platform.h>
#include <linux/platform_device.h>

#include <asm/mach-ath79/ath79.h>
#include <asm/mach-ath79/ar71xx_regs.h>

#include "common.h"
#include "dev-ap9x-pci.h"
#include "dev-eth.h"
#include "dev-gpio-buttons.h"
#include "dev-leds-gpio.h"
#include "dev-m25p80.h"
#include "dev-usb.h"
#include "dev-wmac.h"
#include "machtypes.h"

#define ZODIAC_WX_GPIO_LED_SYSTEM	1
#define ZODIAC_WX_GPIO_LED_WLAN2G	19

#define ZODIAC_WX_GPIO_BTN_RESET	2

#define ZODIAC_WX_KEYS_POLL_INTERVAL	20
#define ZODIAC_WX_KEYS_DEBOUNCE_INTERVAL	\
		(3 * ZODIAC_WX_KEYS_POLL_INTERVAL)

static struct gpio_led zodiac_wx_leds_gpio[] __initdata = {
	{
		.name		= "zodiac-wx:green:system",
		.gpio		= ZODIAC_WX_GPIO_LED_SYSTEM,
		.active_low	= 1,
	},
	{
		.name		= "zodiac-wx:blue:wlan2g",
		.gpio		= ZODIAC_WX_GPIO_LED_WLAN2G,
		.active_low	= 1,
	},
};

static struct gpio_keys_button zodiac_wx_gpio_keys[] __initdata = {
	{
		.desc		= "reset",
		.type		= EV_KEY,
		.code		= KEY_RESTART,
		.debounce_interval = ZODIAC_WX_KEYS_DEBOUNCE_INTERVAL,
		.gpio		= ZODIAC_WX_GPIO_BTN_RESET,
		.active_low	= 1,
	},
};

static const struct ar8327_led_info zodiac_wx_leds_qca833x[] = {
	AR8327_LED_INFO(PHY1_0, HW, "zodiac-wx:green:lan"),
	AR8327_LED_INFO(PHY2_0, HW, "zodiac-wx:green:wan"),
};

/* Blink rate: 1 Gbps -> 8 hz, 100 Mbs -> 4 Hz, 10 Mbps -> 2 Hz */
static struct ar8327_led_cfg zodiac_wx_qca833x_led_cfg = {
	.led_ctrl0 = 0xcf37cf37,
	.led_ctrl1 = 0xcf37cf37,
	.led_ctrl2 = 0xcf37cf37,
	.led_ctrl3 = 0x0,
	.open_drain = true,
};

static struct ar8327_pad_cfg zodiac_wx_qca833x_pad0_cfg = {
	.mode = AR8327_PAD_MAC_SGMII,
	.sgmii_delay_en = true,
};

static struct ar8327_platform_data zodiac_wx_qca833x_data = {
	.pad0_cfg = &zodiac_wx_qca833x_pad0_cfg,
	.port0_cfg = {
		.force_link = 1,
		.speed = AR8327_PORT_SPEED_1000,
		.duplex = 1,
		.txpause = 1,
		.rxpause = 1,
	},
	.led_cfg = &zodiac_wx_qca833x_led_cfg,
};

static struct mdio_board_info zodiac_wx_mdio0_info[] = {
	{
		.bus_id = "ag71xx-mdio.0",
		.phy_addr = 0,
		.platform_data = &zodiac_wx_qca833x_data,
	},
};

static void __init zodiac_wx_common_setup(void)
{
	u8 *mac = (u8 *) KSEG1ADDR(0x1fff0000);

	ath79_register_m25p80(NULL);

	ath79_register_mdio(0, 0x0);
	mdiobus_register_board_info(zodiac_wx_mdio0_info,
				    ARRAY_SIZE(zodiac_wx_mdio0_info));

	/* GMAC0 is connected to QCA8334/QCA8337N switch */
	ath79_eth0_data.mii_bus_dev = &ath79_mdio0_device.dev;
	ath79_eth0_data.phy_if_mode = PHY_INTERFACE_MODE_SGMII;
	ath79_eth0_data.phy_mask = BIT(0);
	ath79_eth0_data.speed = SPEED_1000;
	ath79_eth0_data.duplex = DUPLEX_FULL;

	ath79_init_mac(ath79_eth0_data.mac_addr, mac, 0);
	ath79_register_eth(0);

	ath79_register_wmac(mac + 0x1000, NULL);

	ap91_pci_init(mac + 0x5000, NULL);

	ath79_gpio_direction_select(ZODIAC_WX_GPIO_LED_SYSTEM, true);
	ath79_gpio_direction_select(ZODIAC_WX_GPIO_LED_WLAN2G, true);

	/* Mute LEDs on boot */
	gpio_set_value(ZODIAC_WX_GPIO_LED_SYSTEM, 1);
	gpio_set_value(ZODIAC_WX_GPIO_LED_WLAN2G, 1);

	ath79_gpio_output_select(ZODIAC_WX_GPIO_LED_SYSTEM, 0);
	ath79_gpio_output_select(ZODIAC_WX_GPIO_LED_WLAN2G, 0);

	ath79_register_gpio_keys_polled(-1, ZODIAC_WX_KEYS_POLL_INTERVAL,
					ARRAY_SIZE(zodiac_wx_gpio_keys),
					zodiac_wx_gpio_keys);
}

static void __init zodiac_wx_setup(void)
{
	zodiac_wx_qca833x_data.leds = zodiac_wx_leds_qca833x;
	zodiac_wx_qca833x_data.num_leds = ARRAY_SIZE(zodiac_wx_leds_qca833x);

	zodiac_wx_common_setup();

	ath79_register_leds_gpio(-1, ARRAY_SIZE(zodiac_wx_leds_gpio),
				 zodiac_wx_leds_gpio);
}

MIPS_MACHINE(ATH79_MACH_ZODIAC_WX, "ZODIAC-WX", "Northbound Networks Zodiac WX", zodiac_wx_setup);
