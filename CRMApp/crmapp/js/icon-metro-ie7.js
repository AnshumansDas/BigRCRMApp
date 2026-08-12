/* To avoid CSS expressions while still supporting IE 7 and IE 6, use this script */
/* The script tag referencing this file must be placed before the ending body tag. */

/* Use conditional comments in order to target IE 7 and older:
	<!--[if lt IE 8]><!-->
	<script src="ie7/ie7.js"></script>
	<!--<![endif]-->
*/

(function() {
	function addIcon(el, entity) {
		var html = el.innerHTML;
		el.innerHTML = '<span style="font-family: \'icon-metro\'">' + entity + '</span>' + html;
	}
	var icons = {
		'ico-house': '&#xe900;',
		'ico-flyers': '&#xe901;',
		'ico-signal-waves': '&#xe902;',
		'ico-coupon': '&#xe903;',
		'ico-user': '&#xe904;',
		'ico-calendar-with-a-clock-time-tools': '&#xe905;',
		'ico-call': '&#xe906;',
		'ico-shop': '&#xe907;',
		'ico-favorite_white': '&#xe908;',
		'ico-cutlery': '&#xe909;',
		'ico-travel': '&#xe90a;',
		'ico-washing-machine': '&#xe90b;',
		'ico-weightlifting': '&#xe90c;',
		'ico-makeup': '&#xe90d;',
		'ico-racing': '&#xe90e;',
		'ico-more-button-interface-symbol-of-three-horizontal-aligned-dots': '&#xe90f;',
		'ico-supermarket_white': '&#xe910;',
		'ico-search': '&#xe911;',
		'ico-avatar': '&#xe912;',
		'ico-product': '&#xe913;',
		'ico-event': '&#xe914;',
		'ico-credit-card': '&#xe915;',
		'ico-ring': '&#xe916;',
		'ico-feedback': '&#xe917;',
		'ico-logout': '&#xe918;',
		'ico-edit_white': '&#xe919;',
		'ico-joystick': '&#xe91a;',
		'0': 0
		},
		els = document.getElementsByTagName('*'),
		i, c, el;
	for (i = 0; ; i += 1) {
		el = els[i];
		if(!el) {
			break;
		}
		c = el.className;
		c = c.match(/ico-[^\s'"]+/);
		if (c && icons[c[0]]) {
			addIcon(el, icons[c[0]]);
		}
	}
}());
