<?php
$addons = $GLOBALS['addons'];
?>
<button type="button" class="btn btn-default btn-sm btn-desktop" onclick="design.selectAll()">
	<i class="fa fa-check"></i><small><?php echo $addons->__('addon_select_all_button_title'); ?></small>
</button>
<li style="display: none;">
	<button type="button" class="btn btn-default btn-sm" onclick="design.selectAll()">
		<i class="glyph-icon flaticon-check"></i><small><?php echo $addons->__('addon_select_all_button_title'); ?></small>
	</button>
</li>