<?php  
	$theme  = $themename;
	$span = floor(12/$cols);
	$active = 'latest';
	$id = rand(1,9);
	$themeConfig  	 			= (array)$sconfig->get('themecontrol');
	$listingConfig  			= array( 		
		'category_pzoom' 		=> 1,
		'show_swap_image' 		=> 0,
		'quickview' 			=> 0,
		'product_layout'		=> 'default',
		'catalog_mode'			=> '',
	); 
	$listingConfig  			= array_merge($listingConfig, $themeConfig );
	$DISPLAY_MODE 	 	= $listingConfig['cateogry_display_mode'];
	$categoryPzoom 	    		= $listingConfig['category_pzoom'];
	$quickview 					= $listingConfig['quickview'];
	$swapimg 					= ($listingConfig['show_swap_image'])?'swap':'';
	$productLayout = DIR_TEMPLATE.$theme.'/template/common/product/deal_default.tpl';	 

?>	

<div id="products" class="product-<?php echo $DISPLAY_MODE; ?> productdeals"> 
	<div class="products-block">
		<?php
		$span = floor(12/$cols);
		foreach ($products as $i => $product) { ?>
		<?php if( $i++%$cols == 0 ) { ?>
		<div class="row products-row">
		<?php } ?>
		<?php
			// echo $listingConfig['product_layout']; die;
		?>
		<div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-6 col-xs-12 product-col">			
			
			<?php require($productLayout);  ?>   	
		</div>
		
		<?php if( $i%$cols == 0 || $i==count($products) ) { ?>
		</div>
		<?php } ?>				
		<?php } ?>
	</div>
</div>

<div class="paging space-padding-tb-30 clearfix">
	<div class="pull-left"><?php echo $pagination; ?></div>
	<div class="pull-right"><?php echo $results; ?></div>
</div>

