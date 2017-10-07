<?php echo $header; 
$theme_options = $registry->get('theme_options');
$config = $registry->get('config');
$page_direction = $theme_options->get( 'page_direction' ); 
$background_status = false;
$product_page = true;
include('catalog/view/theme/'.$config->get('theme_' . $config->get('config_theme') . '_directory').'/template/new_elements/wrapper_top.tpl'); ?>

<div itemscope itemtype="http://schema.org/Product"> <span itemprop="name" class="hidden"><?php echo $heading_title; ?></span>
  <div class="product-info">
    <div class="row">
      <?php $product_custom_block = $modules_old_opencart->getModules('product_custom_block'); ?>
      <div class="col-md-<?php if($theme_options->get( 'custom_block', 'product_page', $config->get( 'config_language_id' ), 'status' ) == 1 || count($product_custom_block)) { echo 9; } else { echo 12; } ?> col-sm-12">
        <div class="row" id="quickview_product">
          <?php if($theme_options->get( 'product_image_zoom' ) != 2) { ?>
          <script>
			    	$(document).ready(function(){
			    	     if($(window).width() > 992) {
     			    		<?php if($theme_options->get( 'product_image_zoom' ) == 1) { ?>
     			    			$('#image').elevateZoom({
     			    				zoomType: "inner",
     			    				cursor: "pointer",
     			    				zoomWindowFadeIn: 500,
     			    				zoomWindowFadeOut: 750
     			    			});
     			    		<?php } else { ?>
     				    		$('#image').elevateZoom({
     								zoomWindowFadeIn: 500,
     								zoomWindowFadeOut: 500,
     								zoomWindowOffetx: 20,
     								zoomWindowOffety: -1,
     								cursor: "pointer",
     								lensFadeIn: 500,
     								lensFadeOut: 500,
     								zoomWindowWidth: 500,
     								zoomWindowHeight: 500
     				    		});
     			    		<?php } ?>
     			    		
     			    		var z_index = 0;
     			    		
     			    		$(document).on('click', '.open-popup-image', function () {
     			    		  $('.popup-gallery').magnificPopup('open', z_index);
     			    		  return false;
     			    		});
			    		
     			    		$('.thumbnails a, .thumbnails-carousel a').click(function() {
     			    			var smallImage = $(this).attr('data-image');
     			    			var largeImage = $(this).attr('data-zoom-image');
     			    			var ez =   $('#image').data('elevateZoom');	
     			    			$('#ex1').attr('href', largeImage);  
     			    			ez.swaptheimage(smallImage, largeImage); 
     			    			z_index = $(this).index('.thumbnails a, .thumbnails-carousel a');
     			    			return false;
     			    		});
			    		} else {
			    			$(document).on('click', '.open-popup-image', function () {
			    			  $('.popup-gallery').magnificPopup('open', 0);
			    			  return false;
			    			});
			    		}
			    	});
			    </script>
          <?php } ?>
          <?php $image_grid = 7; $product_center_grid = 5; 
			    if ($theme_options->get( 'product_image_size' ) == 1) {
			    	$image_grid = 4; $product_center_grid = 8;
			    }
			    
			    if ($theme_options->get( 'product_image_size' ) == 3) {
			    	$image_grid = 8; $product_center_grid = 4;
			    }
			    ?>
          <div class="col-sm-<?php echo $image_grid; ?> popup-gallery">
            <?php 
			      $product_image_top = $modules_old_opencart->getModules('product_image_top');
			      if( count($product_image_top) ) { 
			      	foreach ($product_image_top as $module) {
			      		echo $module;
			      	}
			      } ?>
            <div class="row">
              <?php if (($images || $theme_options->get( 'product_image_zoom' ) != 2) && $theme_options->get( 'position_image_additional' ) == 2) { ?>
              <div class="col-sm-2">
                <div class="thumbnails thumbnails-left clearfix"> 
                <ul>
							  
						      <li><img id="design-img" src="http://52.36.35.1//tshirtecommerce//uploaded/2017/10/cart-front-1507268538.png" /></li>
                  </ul>
                  <!--<ul>
							  <?php if($theme_options->get( 'product_image_zoom' ) != 2 && $thumb) { ?>
						      <li><p><a href="<?php echo $popup; ?>" class="popup-image" data-image="<?php echo $thumb; ?>" data-zoom-image="<?php echo $popup; ?>"><img src="<?php echo $theme_options->productImageThumb($product_id, $config->get('theme_default_image_additional_width'), $config->get('theme_default_image_additional_height')); ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a></p></li>
							  <?php } ?>
						      <?php foreach ($images as $image) { ?>
						      <li><p><a href="<?php echo $image['popup']; ?>" class="popup-image" data-image="<?php echo $image['popup']; ?>" data-zoom-image="<?php echo $image['popup']; ?>"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a></p></li>
						      <?php } ?>
						  </ul>--> 
                </div>
              </div>
              <?php } ?>
              <div class="col-sm-<?php if($theme_options->get( 'position_image_additional' ) == 2) { echo 10; } else { echo 12; } ?>">
                <?php if ($thumb) { ?>
                <div class="product-image <?php if($theme_options->get( 'product_image_zoom' ) != 2) { if($theme_options->get( 'product_image_zoom' ) == 1) { echo 'inner-cloud-zoom'; } else { echo 'cloud-zoom'; } } ?>">
                  <?php if($special && $theme_options->get( 'display_text_sale' ) != '0') { ?>
                  <?php $text_sale = 'Sale';
					      	 	if($theme_options->get( 'sale_text', $config->get( 'config_language_id' ) ) != '') {
					      	 		$text_sale = $theme_options->get( 'sale_text', $config->get( 'config_language_id' ) );
					      	 	} ?>
                  <?php if($theme_options->get( 'type_sale' ) == '1') { ?>
                  <?php $product_detail = $theme_options->getDataProduct( $product_id );
					      	 	$roznica_ceny = $product_detail['price']-$product_detail['special'];
					      	 	$procent = ($roznica_ceny*100)/$product_detail['price']; ?>
                  <div class="sale">-<?php echo round($procent); ?>%</div>
                  <?php } else { ?>
                  <div class="sale"><?php echo $text_sale; ?></div>
                  <?php } ?>
                  <?php } elseif($theme_options->get( 'display_text_new' ) != '0' && $theme_options->isLatestProduct( $product_id )) { ?>
                  <div class="new">
                    <?php if($theme_options->get( 'new_text', $config->get( 'config_language_id' ) ) != '') { echo $theme_options->get( 'new_text', $config->get( 'config_language_id' ) ); } else { echo 'New'; } ?>
                  </div>
                  <?php } ?>
                  <a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" id="ex1" <?php if($theme_options->get( 'product_image_zoom' ) == 2) { ?>class="popup-image"<?php } else { echo 'class="open-popup-image"'; } ?>><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" itemprop="image" data-zoom-image="<?php echo $popup; ?>" /></a> </div>
                <?php } else { ?>
                <div class="product-image"> <img src="image/no_image.jpg" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" itemprop="image" /> </div>
                <?php } ?>
              </div>
              <?php if (($images || $theme_options->get( 'product_image_zoom' ) != 2) && $theme_options->get( 'position_image_additional' ) != 2) { ?>
              <div class="col-sm-12">
                <div class="overflow-thumbnails-carousel clearfix">
                  <div class="thumbnails-carousel owl-carousel">
                    <?php if($theme_options->get( 'product_image_zoom' ) != 2 && $thumb) { ?>
                    <div class="item"><a href="<?php echo $popup; ?>" class="popup-image" data-image="<?php echo $thumb; ?>" data-zoom-image="<?php echo $popup; ?>"><img src="<?php echo $theme_options->productImageThumb($product_id, $config->get('theme_default_image_additional_width'), $config->get('theme_default_image_additional_height')); ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a></div>
                    <?php } ?>
                    <?php foreach ($images as $image) { ?>
                    <div class="item"><a href="<?php echo $image['popup']; ?>" class="popup-image" data-image="<?php echo $image['popup']; ?>" data-zoom-image="<?php echo $image['popup']; ?>"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a></div>
                    <?php } ?>
                  </div>
                </div>
                <script type="text/javascript">
					           $(document).ready(function() {
					             $(".thumbnails-carousel").owlCarousel({
					                 autoPlay: 6000, //Set AutoPlay to 3 seconds
					                 navigation: true,
					                 navigationText: ['', ''],
					                 itemsCustom : [
					                   [0, 4],
					                   [450, 5],
					                   [550, 6],
					                   [768, 3],
					                   [1200, 4]
					                 ],
					                 <?php if($page_direction[$config->get( 'config_language_id' )] == 'RTL'): ?>
					                 direction: 'rtl'
					                 <?php endif; ?>
					             });
					           });
					      </script> 
              </div>
              <?php } ?>
            </div>
            <?php 
			      $product_image_bottom = $modules_old_opencart->getModules('product_image_bottom');
			      if( count($product_image_bottom) ) { 
			      	foreach ($product_image_bottom as $module) {
			      		echo $module;
			      	}
			      } ?>
          </div>
          <div class="col-sm-<?php echo $product_center_grid; ?> product-center clearfix">
            <div itemscope itemtype="http://schema.org/Offer">
              <?php 
			      $product_options_top = $modules_old_opencart->getModules('product_options_top');
			      if( count($product_options_top) ) { 
			      	foreach ($product_options_top as $module) {
			      		echo $module;
			      	}
			      } ?>
              <?php if ($review_status) { ?>
              <div class="review">
                <?php if($rating > 0) { ?>
                <span itemprop="review" class="hidden" itemscope itemtype="http://schema.org/Review-aggregate"> <span itemprop="itemreviewed"><?php echo $heading_title; ?></span> <span itemprop="rating"><?php echo $rating; ?></span> <span itemprop="votes">
                <?php preg_match_all('/\(([0-9]+)\)/', $tab_review, $wyniki);
			      		if(isset($wyniki[1][0])) { echo $wyniki[1][0]; } else { echo 0; } ?>
                </span> </span>
                <?php } ?>
                <div class="rating"><i class="fa fa-star<?php if($rating >= 1) { echo ' active'; } ?>"></i><i class="fa fa-star<?php if($rating >= 2) { echo ' active'; } ?>"></i><i class="fa fa-star<?php if($rating >= 3) { echo ' active'; } ?>"></i><i class="fa fa-star<?php if($rating >= 4) { echo ' active'; } ?>"></i><i class="fa fa-star<?php if($rating >= 5) { echo ' active'; } ?>"></i>&nbsp;&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click'); $('html, body').animate({scrollTop:$('#tab-review').offset().top}, '500', 'swing');"><?php echo $reviews; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click'); $('html, body').animate({scrollTop:$('#tab-review').offset().top}, '500', 'swing');"><?php echo $text_write; ?></a></div>
              </div>
              <?php } ?>
              <div class="description">
              <h1 id="title-page"><?php echo $heading_title ?></h1>
                
                <?php if ($manufacturer) { ?>
                <span><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a><br />
                <?php } ?>
                <span><?php echo $text_model; ?></span> <?php echo $model; ?><br />
                <?php if ($reward) { ?>
                <span><?php echo $text_reward; ?></span> <?php echo $reward; ?><br />
                <?php } ?>
                <span><?php echo $text_stock; ?></span> <?php echo $stock; ?></div>
              <?php if ($price) { ?>
              <div class="price">
                <?php if($theme_options->get( 'display_specials_countdown' ) == '1' && $special) { $countdown = rand(0, 5000)*rand(0, 5000); 
			                  $product_detail = $theme_options->getDataProduct( $product_id );
			                  $date_end = $product_detail['date_end'];
			                  if($date_end != '0000-00-00' && $date_end) { ?>
                <script>
			             		$(function () {
			             			var austDay = new Date();
			             			austDay = new Date(<?php echo date("Y", strtotime($date_end)); ?>, <?php echo date("m", strtotime($date_end)); ?> - 1, <?php echo date("d", strtotime($date_end)); ?>);
			             			$('#countdown<?php echo $countdown; ?>').countdown({until: austDay});
			             		});
			             		</script>
                <h3>
                  <?php if($theme_options->get( 'limited_time_offer_text', $config->get( 'config_language_id' ) ) != '') { echo $theme_options->get( 'limited_time_offer_text', $config->get( 'config_language_id' ) ); } else { echo 'Limited time offer'; } ?>
                </h3>
                <div id="countdown<?php echo $countdown; ?>" class="clearfix"></div>
                <?php } ?>
                <?php } ?>
                <?php if (!$special) { ?>
                <span class="price-new"><span itemprop="price" id="price-old"><?php echo $price; ?></span></span>
                <?php } else { ?>
                <span class="price-new"><span itemprop="price" id="price-special"><?php echo $special; ?></span></span> <span class="price-old" id="price-old"><?php echo $price; ?></span>
                <?php } ?>
                <br />
                <?php if ($tax) { ?>
                <span class="price-tax"><?php echo $text_tax; ?> <span id="price-tax"><?php echo $tax; ?></span></span><br />
                <?php } ?>
              </div>
              <?php } ?>
            </div>
            
            <!-- End #product --> 
            
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<div class="box clearfix box-with-products box-no-advanced with-scroll" style="margin-bottom:20px;"> 
  <!-- Carousel nav -->
  
  <div class="box-heading">Design Product</div>
  <!--<div style="float:right"><p>We accept the following file types: <strong>png, jpg, gif</strong></p></div>-->
  <div class="strip-line"></div>
  <div class="clear"></div>
  </div>
  <div class="htmleaf-container">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<input type="file" multiple id="ssi-upload"/>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
</div>
</div>
</div>
<?php echo $footer; ?>
	<link rel="stylesheet" type="text/css" href="/catalog/view/theme/fastor/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="/catalog/view/theme/fastor/css/htmleaf-demo.css">
	<link rel="stylesheet" href="/catalog/view/theme/fastor/css/ssi-uploader.css"/>
	<!--[if IE]>
		<script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
	<![endif]-->
    <script src="/catalog/view/theme/fastor/js/jquery.min.js" type="text/javascript"></script>
	<script>window.jQuery || document.write('<script src="/catalog/view/theme/fastor/js/jquery-2.1.1.min.js"><\/script>')</script>
	<script src="/catalog/view/theme/fastor/js/ssi-uploader.js"></script>
	<script type="text/javascript">
		$('#ssi-upload').ssi_uploader({url:'/tshirtecommerce/ajax.php?type=upload&remove=0',maxFileSize:6,allowed:['jpg','gif','png']});
	</script>
<style>
.breadcrumb{
	display:none;
}
</style>