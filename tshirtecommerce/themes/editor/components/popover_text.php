<?php
$addons = $GLOBALS['addons'];
?>
<div id="options-add_item_text" class="dg-options">
	<div class="dg-options-toolbar">
		<div class="toolbar-text">
			<textarea class="form-control text-update" data-event="keyup" data-label="text" id="enter-text"></textarea> <i class="fa fa-pencil"></i>
		</div>
		<button class="btn btn-default toolbar-font" data-target="#dg-fonts" data-toggle="modal">
			<a id="txt-fontfamily" class="pull-left" href="javascript:void(0)">
				<?php echo lang('designer_clipart_edit_arial'); ?>
			</a>
			<i class="fa fa-angle-down" aria-hidden="true"></i>
		</button>
		
		<div class="list-colors">
			<a class="dropdown-color" id="txt-color" href="javascript:void(0)" data-color="black" data-label="color" style="background-color:black"></a>
		</div>
		<div class="dropdown dropdown-none">
			<button class="btn btn-sm btn-none dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
				<?php echo lang('designer_clipart_edit_out_line'); ?> <i class="fa fa-angle-down" aria-hidden="true"></i>
			</button>
			<div class="option-outline dropdown-menu">
				<div class="dropdown-outline">
					<span><?php echo lang('designer_clipart_edit_size'); ?></span>
					<a data-toggle="dropdown" class="dg-outline-value" href="javascript:void(0)">
						<span class="outline-value pull-left">0</span>
					</a>
					<div id="dg-outline-width"></div>
				</div>
				<div class="list-colors">
					<span><?php echo lang('designer_color'); ?></span>
					<a class="dropdown-color pull-right bg-none" data-label="outline" data-placement="top" href="javascript:void(0)" data-color="none">
						<span class="ui-accordion-header-icon ui-icon ui-icon-triangle-1-s"></span>
					</a>
				</div>
			</div>
		</div>
		
		<div class="rotate">
			<span class="rotate-values"><input type="text" value="0" class="rotate-value" id="text-rotate-value" /></span>			
			<span class="rotate-deg"></span>
		</div>
			
		<div class="toolbar-size">
			<input type="text" size="2" id="text-width" readonly disabled> 
			<a href="javascript:void(0);" class="icon-ui-lock" title="<?php echo lang('designer_clipart_edit_unlock_proportion'); ?>">
				<i class="fa fa-lock" aria-hidden="true"></i>
			</a>
			<input type="text" size="2" id="text-height" readonly disabled>
			
			<input type="checkbox" style="display:none;" class="ui-lock" id="text-lock" />
		</div>
		
		<div class="dropdown dropdown-none">
			<button class="btn btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
				<?php echo lang('designer_more'); ?> <i class="fa fa-angle-down" aria-hidden="true"></i>
			</button>
			<div class="dropdown-menu">
				<div id="text-align">
					<span id="text-align-left" class="text-update btn btn-sm glyphicons align_left glyphicons-12" data-event="click" data-label="alignL"></span>
					<span id="text-align-center" class="text-update btn btn-sm glyphicons align_center glyphicons-12" data-event="click" data-label="alignC"></span>
					<span id="text-align-right" class="text-update btn btn-sm glyphicons align_right glyphicons-12" data-event="click" data-label="alignR"></span>
				</div>
			
				<div id="text-style">
					<span id="text-style-i" class="text-update btn btn-sm glyphicons italic glyphicons-12" data-event="click" data-label="styleI"></span>
					<span id="text-style-b" class="text-update btn btn-sm glyphicons bold glyphicons-12" data-event="click" data-label="styleB"></span>							
					<span id="text-style-u" class="text-update btn btn-sm glyphicons text_underline glyphicons-12" data-event="click" data-label="styleU"></span>
				</div>
			</div>
		</div>
		
		<?php $addons->view('text-mobile', array(), 'editor'); ?>
	</div>
	
	<div class="dg-options-content">
		<?php $addons->text(); ?>		
	</div>
</div>