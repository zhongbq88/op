<?php 
  
	$config = $sconfig;

  $themeConfig = (array)$config->get('themecontrol');
  $productConfig = array(     
      'product_enablezoom'         => 1,
      'product_zoommode'           => 'basic',
      'product_zoomeasing'         => 1,
      'product_zoomlensshape'      => "round",
      'product_zoomlenssize'       => "150",
      'product_zoomgallery'        => 0,
      'enable_product_customtab'   => 0,
      'product_customtab_name'     => '',
      'product_customtab_content'  => '',
      'product_related_column'     => 0,        
    );
    $listingConfig = array(   
      'category_pzoom'                    => 1, 
      'quickview'                                 => 0,
      'show_swap_image'                         => 0,
      'catalog_mode'                => 1,
      'layout_pinfo' => 'default'
    ); 
    $listingConfig          = array_merge($listingConfig, $themeConfig );
    $categoryPzoom            = $listingConfig['category_pzoom']; 
    $quickview                = $listingConfig['quickview'];
    $swapimg                  = ($listingConfig['show_swap_image'])?'swap':'';
    $productConfig                = array_merge( $productConfig, $themeConfig );  
    $languageID               = $config->get('config_language_id');   

    $layout_pinfo = $listingConfig['layout_pinfo']; 
    $layout_detail = $listingConfig['product_detail']; 
    
?>
<?php echo $header; ?>
<div class="breadcrumb">
  <div class="container">
    <h1><?php echo $heading_title; ?></h1>
    <ul>
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
      <?php } ?>
    </ul>      
  </div>   
</div>
<div class="container">
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-md-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-md-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-md-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <div class="product-info">
        <div class="row">
          <?php if ($column_left || $column_right) { ?>
          <?php $class = 'col-md-6 col-sm-6'; ?>
          <?php } else { ?>
          <?php $class = 'col-md-6'; ?>
          <?php } ?>
          
          <?php require( ThemeControlHelper::getLayoutPath( 'product/preview/'.$layout_detail.'.tpl' ) );  ?>
          <?php if ($column_left || $column_right) { ?>
          <?php $class = 'col-md-6 col-sm-6'; ?>
          <?php } else { ?>
          <?php $class = 'col-md-6'; ?>
          <?php } ?>
          <div class="<?php echo $class; ?> col-sm-6 space-padding-lr-7">
          
            <h1 class="name"><?php echo $heading_title; ?></h1>
        
            <?php if ($review_status) { ?>
            <div class="rating">
              <p>
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                <?php if ($rating < $i) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } else { ?>
                <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } ?>
                <?php } ?>
                <a href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;"><?php echo $reviews; ?></a> 
                </p>
              
            </div>
            <?php } ?>

             <?php if ($price) { ?>
              <div class="price detail">
                  <ul class="list-unstyled">
                      <?php if (!$special) { ?>
                          <li>
                              <span class="price-new"> <?php echo $price; ?> </span>
                          </li>
                      <?php } else { ?>

                          <li> <span class="price-new"> <?php echo $special; ?> </span> <span class="price-old"><?php echo $price; ?></span> </li>
                      <?php } ?>
                  </ul>
              </div>
          <?php } ?>
    
          <ul class="list-unstyled">
              <?php if ($tax) { ?>
                  <li><?php echo $text_tax; ?> <?php echo $tax; ?></li>
              <?php } ?>

              <?php if ($discounts) { ?>
                  <li>
                  </li>
                  <?php foreach ($discounts as $discount) { ?>
                      <li><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></li>
                  <?php } ?>
              <?php } ?>
          </ul>
          
                     
          <ul class="list-unstyled">
              <?php if ($stock) { ?>
              <li><span class="check-box text-primary"><i class="zmdi zmdi-check zmdi-hc-fw"></i></span><?php echo $text_stock; ?><?php echo $stock; ?></li>
              <?php } ?>  
              <?php if ($manufacturer) { ?>
                  <li><span class="check-box text-primary"><i class="zmdi zmdi-check zmdi-hc-fw"></i></span><?php echo $text_manufacturer; ?> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a></li>
              <?php } ?>
              <li><span class="check-box text-primary"><i class="zmdi zmdi-check zmdi-hc-fw"></i></span><?php echo $text_model; ?> <?php echo $model; ?></li>
              <?php if ($reward) { ?>
                  <li><span class="check-box text-primary"><i class="zmdi zmdi-check zmdi-hc-fw"></i></span><?php echo $text_reward; ?> <?php echo $reward; ?></li>
              <?php } ?>
              <?php if ($points) { ?>
                  <li><span class="check-box text-primary"><i class="zmdi zmdi-check zmdi-hc-fw"></i></span><?php echo $text_points; ?> <?php echo $points; ?></li>
              <?php } ?>
          </ul>
         
        
            <div id="product">
              <?php if ($options) { ?>
              <hr>
              <h3><?php echo $text_option; ?></h3>
              <?php foreach ($options as $option) { ?>
              <?php if ($option['type'] == 'select') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                  <option value=""><?php echo $text_select; ?></option>
                  <?php foreach ($option['product_option_value'] as $option_value) { ?>
                  <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                  <?php if ($option_value['price']) { ?>
                  (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                  <?php } ?>
                  </option>
                  <?php } ?>
                </select>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'radio') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> form-group-v2">
                <label class="control-label"><?php echo $option['name']; ?></label>
                <div id="input-option<?php echo $option['product_option_id']; ?>">
                  <?php foreach ($option['product_option_value'] as $option_value) { ?>
                  <div class="radio">
                    <label>
                      <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                      <?php echo $option_value['name']; ?>
                      <?php if ($option_value['price']) { ?>
                      (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                      <?php } ?>
                    </label>
                  </div>
                  <?php } ?>
                </div>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'checkbox') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> form-group-v2">
                <label class="control-label"><?php echo $option['name']; ?></label>
                <div id="input-option<?php echo $option['product_option_id']; ?>">
                  <?php foreach ($option['product_option_value'] as $option_value) { ?>
                  <div class="checkbox">
                    <label>
                      <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                      <?php echo $option_value['name']; ?>
                      <?php if ($option_value['price']) { ?>
                      (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                      <?php } ?>
                    </label>
                  </div>
                  <?php } ?>
                </div>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'image') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> form-group-v2">
                <label class="control-label"><?php echo $option['name']; ?></label>
                <div id="input-option<?php echo $option['product_option_id']; ?>">
                  <?php foreach ($option['product_option_value'] as $option_value) { ?>
                  <div class="radio">
                    <label>
                      <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                      <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> <?php echo $option_value['name']; ?>
                      <?php if ($option_value['price']) { ?>
                      (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                      <?php } ?>
                    </label>
                  </div>
                  <?php } ?>
                </div>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'text') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'textarea') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'file') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                <label class="control-label"><?php echo $option['name']; ?></label>
                <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'date') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                <div class="input-group date">
                  <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                  <span class="input-group-btn">
                  <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                  </span></div>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'datetime') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                <div class="input-group datetime">
                  <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                  <span class="input-group-btn">
                  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  </span></div>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'time') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                <div class="input-group time">
                  <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                  <span class="input-group-btn">
                  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  </span></div>
              </div>
              <?php } ?>
              <?php } ?>
              <?php } ?>
              <?php if ($recurrings) { ?>
              <hr>
              <h3><?php echo $text_payment_recurring ?></h3>
              <div class="form-group required">
                <select name="recurring_id" class="form-control">
                  <option value=""><?php echo $text_select; ?></option>
                  <?php foreach ($recurrings as $recurring) { ?>
                  <option value="<?php echo $recurring['recurring_id'] ?>"><?php echo $recurring['name'] ?></option>
                  <?php } ?>
                </select>
                <div class="help-block" id="recurring-description"></div>
              </div>
              <?php } ?>
                          
              <div class="product-buttons-wrap">
                <div class="product-qyt-action space-padding-b-45 clearfix border-bottom">
                    <div class="quantity-title qty"><?php echo $objlang->get("entry_qty"); ?></div>
                    
                    <div class="quantity-adder pull-left">
                        <span class="add-down add-action">
                            <i class="fa fa-minus"></i>
                        </span>
                        <span class="quantity-number">
                            <input type="text" name="quantity" value="<?php echo $minimum; ?>" size="2" id="input-quantity" class="form-control" />
                        </span>
                        <span class="add-up add-action">
                            <i class="fa fa-plus"></i>
                        </span>                    
                    </div>               
                </div>
           
                <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
                <div class="clearfix space-padding-tb-35-25">
                <div class="pull-left space-right-15">

				<?php $e_validate_input_order = false; ?>
				<ul class="list-unstyled">
					<?php
						$design_product_id_arr = explode(':', $design_product_id);
						$e_design_product_id = 0;
						$e_design_product_id = (count($design_product_id_arr) > 1) ? (isset($design_product_id_arr[2]) ? $design_product_id_arr[2] : 0) : $design_product_id;

						$file = dirname(DIR_SYSTEM).'/tshirtecommerce/data/products.json';
						if (file_exists($file)) {			
							$string = file_get_contents($file);
							if ($string != false) {
								$e_products = json_decode($string);
								if (isset($e_products->products) && count($e_products->products) > 0) {
									foreach ($e_products->products as $values) {
										if (isset($e_design_product_id) && $e_design_product_id != '' && $e_design_product_id == $values->id && isset($values->show_attribute)) { ?>
											<div class="row designer-attributes">
												<link href="<?php echo $site_url; ?>/tshirtecommerce/opencart/css/product.css" rel="stylesheet">
												<script src="<?php echo $site_url; ?>/tshirtecommerce/opencart/js/product.js"></script>
												<?php if(isset($values->design) && isset($values->design->color_hex)) { ?>
													<p><strong><?php echo $design_product_color; ?></strong></p>
													<div class='list-colors' style='margin-bottom:15px;'>
														<?php $color_hex_idx = 0; ?>
														<?php foreach ($values->design->color_hex as $ck => $ch) { ?>
														<?php if ($ch == $tshirtecommerce_color) { ?>
														<?php $color_hex_idx = $ck; ?>
														<a href="<?php echo $tcolor_link; ?>&color=<?php echo $ch; ?>" data-color="<?php echo $ch; ?>" data-index="<?php echo $ck ?>" class="bg-colors active" title="<?php echo $values->design->color_title[$ck] ?>"><span style="width:24px;background-color:#<?php echo $ch ?>;"></span></a>
														<?php } else { ?>
														<a href="<?php echo $tcolor_link; ?>&color=<?php echo $ch; ?>" data-color="<?php echo $ch; ?>" data-index="<?php echo $ck ?>" class="bg-colors" title="<?php echo $values->design->color_title[$ck] ?>"><span style="width:24px;background-color:#<?php echo $ch ?>;"></span></a>
														<?php } ?>
														<?php } ?>
														<input type='hidden' value='<?php echo (isset($design_product_id_arr[0]) ? $design_product_id_arr[0] : '') ?>' name='design[rowid]' id='e_rowid' />
														<input type="hidden" value="<?php echo $tshirtecommerce_color; ?>" id='e_color_hex' name="design[color_hex]" />
														<input type="hidden" value="<?php echo $values->design->color_title[$color_hex_idx] ?>" name="design[color_title]" />
														<input type="hidden" value="<?php echo $values->id ?>" name="design_product_id" />
														<input type="hidden" value="<?php echo $values->id ?>" name="design[design_product_id]" />
														<input type="hidden" value="" name="design[images]" />
														<input type="hidden" value="1" name="design[idea]" />
													</div>
												<?php }
												if (isset($values->show_attribute) && $values->show_attribute == 1 && ! empty($values->attributes)) {
													$e_validate_input_order = true; ?>
													<div class='product-attributes'>
														<input type='hidden' value='<?php echo $oc_minimum ?>' id='e-input-min-order' />
														<input type='hidden' value='<?php echo $oc_quantity ?>' id='e-input-max-order' />
														<?php $e_attr_count = count($values->attributes->name);
														echo '<input type="hidden" value="'.$product_id.'" name="design[product_id]" />';
														for ($ia = 0; $ia < $e_attr_count; $ia++) { ?>
															<div class='form-group product-fields' style='margin-bottom:0!important'><p><strong><?php echo $values->attributes->name[$ia] ?></strong></p></div>
															<div class='dg-poduct-fields'>
																<input type='hidden' value='<?php echo $values->attributes->name[$ia] ?>' name='design[options][<?php echo $ia ?>][name]' />
																<input type='hidden' value='<?php echo $values->attributes->type[$ia] ?>' name='design[options][<?php echo $ia ?>][type]' />
																<?php switch ($values->attributes->type[$ia]) {
																	case 'textlist':
																		echo "<script>document.getElementsByName('quantity')[0].disabled = true;</script><ul id='e-input-options' class='p-color-sizes list-number col-md-12' style='width:100%'>";
																		$iaj = 0;
																		foreach ($values->attributes->titles[$ia] as $value) {
																			echo "<li style='padding-bottom:10px'>";
																			echo "<label>";
																			if (isset($values->attributes->prices[$ia][$iaj]) && $values->attributes->prices[$ia][$iaj] > 0) {
																				$values->attributes->prices[$ia][$iaj] += $values->attributes->prices[$ia][$iaj]*$otaxes;
																				echo $value.'(+'.$values->attributes->prices[$ia][$iaj].')';
																			} elseif (isset($values->attributes->prices[$ia][$iaj]) && $values->attributes->prices[$ia][$iaj] < 0) {
																				$values->attributes->prices[$ia][$iaj] += $values->attributes->prices[$ia][$iaj]*$otaxes;
																				echo $value.'(-'.$values->attributes->prices[$ia][$iaj].')';
																			} else {
																				echo $value;
																			}
																			echo "</label>";
																			if ($iaj == 0) {
																				echo "<input type='text' class='form-control input-sm size-number' name='design[options][$ia][value][$value]' value='$oc_minimum' onchange='e_tshirt_attributes(this, $iaj)' onkeypress='return e_validate_num(event, this)' />";
																			} else {
																				echo "<input type='text' class='form-control input-sm size-number' name='design[options][$ia][value][$value]' value='0' onchange='e_tshirt_attributes(this, $iaj)' onkeypress='return e_validate_num(event, this)' />";
																			}
																			echo "<input type='hidden' name='design[options][$ia][price][$value]' value='".(isset($values->attributes->prices[$ia][$iaj]) ? $values->attributes->prices[$ia][$iaj] : 0)."' />";
																			$iaj++;
																		}
																		break;

																	case 'checkbox':
																		$iaj = 0;
																		echo "<div class='form-group'>";
																		foreach ($values->attributes->titles[$ia] as $value) {
																			echo '<p><label class="checkbox-inline">';
																			if (isset($values->attributes->prices[$ia][$iaj]) && $values->attributes->prices[$ia][$iaj] > 0) {
																				$values->attributes->prices[$ia][$iaj] += $values->attributes->prices[$ia][$iaj]*$otaxes;
																				echo "<input type='checkbox' name='design[options][$ia][value][$iaj]' value='$value' />";
																				echo $value .'(+'.$values->attributes->prices[$ia][$iaj].')';
																			} elseif (isset($values->attributes->prices[$ia][$iaj]) && $values->attributes->prices[$ia][$iaj] < 0) {
																				$values->attributes->prices[$ia][$iaj] += $values->attributes->prices[$ia][$iaj]*$otaxes;
																				echo "<input type='checkbox' name='design[options][$ia][value][$iaj]' value='$value' />";
																				echo $value .'(-'.$values->attributes->prices[$ia][$iaj].')';
																			} else {
																				echo "<input type='checkbox' name='design[options][$ia][value][$iaj]' value='$value' />";
																				echo $value;
																			}
																			echo '</label></p>';
																			$iaj++;
																		}
																		echo '</div>';
																		break;

																	case 'selectbox':
																		$iaj = 0;
																		echo "<div class='form-group'>";
																		echo "<select class='form-control input-sm' name='design[options][$ia][value]'>";
																		foreach ($values->attributes->titles[$ia] as $value) {
																			if (isset($values->attributes->prices[$ia][$iaj]) && $values->attributes->prices[$ia][$iaj] > 0) {
																				$values->attributes->prices[$ia][$iaj] += $values->attributes->prices[$ia][$iaj]*$otaxes;
																				echo "<option value='$value'>$value (+".$values->attributes->prices[$ia][$iaj].")</option>";
																			} elseif (isset($values->attributes->prices[$ia][$iaj]) && $values->attributes->prices[$ia][$iaj] < 0) {
																				$values->attributes->prices[$ia][$iaj] += $values->attributes->prices[$ia][$iaj]*$otaxes;
																				echo "<option value='$value'>$value (-".$values->attributes->prices[$ia][$iaj].")</option>";
																			} else {
																				echo "<option value='$value'>$value</option>";
																			}
																			$iaj++;
																		}
																		echo '</select>';
																		echo '</div>';
																		break;

																	case 'radio';
																		$iaj = 0;
																		echo "<div class='form-group'>";
																		foreach ($values->attributes->titles[$ia] as $value) {
																			echo '<p><label class="radio-inline">';
																			if (isset($values->attributes->prices[$ia][$iaj]) && $values->attributes->prices[$ia][$iaj] > 0) {
																				$values->attributes->prices[$ia][$iaj] += $values->attributes->prices[$ia][$iaj]*$otaxes;
																				echo "<input type='radio' value='$value' name='design[options][$ia][value]' />";
																				echo $value .'(+'.$values->attributes->prices[$ia][$iaj].')';
																			} elseif (isset($values->attributes->prices[$ia][$iaj]) && $values->attributes->prices[$ia][$iaj] < 0) {
																				$values->attributes->prices[$ia][$iaj] += $values->attributes->prices[$ia][$iaj]*$otaxes;
																				echo "<input type='radio' value='$value' name='design[options][$ia][value]' />";
																				echo $value .'(-'.$values->attributes->prices[$ia][$iaj].')';
																			} else {
																				echo "<input type='radio' value='$value' name='design[options][$ia][value]' />";
																				echo $value;
																			}
																			echo '</label></p>';
																			$iaj++;
																		}
																		echo '</div>';
																		break;

																	default:
																		break;
																} ?>
															</div>
														<?php } 
														echo '<input type="hidden" value="'.$tshirtecommerce_printing_type.'" name="design[options]['.$e_attr_count.'][name]" />';
														echo '<input type="hidden" value="printing" name="design[options]['.$e_attr_count.'][type]" />';
														echo '<input type="hidden" value="'. $values->print_type .'" name="design[options]['.$e_attr_count.'][value]" />';
														echo '<input type="hidden" value="'. $values->print_type .'" name="design[design_printing]" />'; ?>
													</div>
													<div class='clear:both;'></div>
												<?php } ?>
											</div>
										<?php }
									}
								}
							}
						} ?>
				</ul>
				<?php if (isset($design_product_id) && $design_product_id != '') {
					$check_idea = explode(':', $design_product_id);
					$parent_id 	= $product_id;
					if (count($check_idea) > 1) {
						if (isset($design_print_price) && $design_print_price != 0) { ?>
							<p><label class="control-label"><?php echo $tshirtecommerce_label_price_of_print; ?> <strong>+<?php echo $design_print_price_lable; ?></strong></label></p>
						<input name='design[oc_price_of_print]' type='hidden' value='<?php echo $design_print_price ?>' />
						<?php }
					} ?>
					<div style='clear:both'></div>
					<?php if (isset($tshirtecommerce_hide_addtocart) && $tshirtecommerce_hide_addtocart == 1) { ?>
						<style>#button-cart{display:none !important;}</style>
					<?php }
					$tscheck_class = explode(':', $tshirtecommerce_customize_design_btn);
					if (count($tscheck_class) > 1) { ?>
						<p><a id="button-design" class="btn btn-primary radius-2x shadow" href="<?php echo $tshirtecommerce_designer_link; ?>"><?php echo $tshirtecommerce_button_custom_your_design; ?></a>
						</p>
					<?php } else { ?>
						<p><a id="button-design" class="btn btn-primary radius-2x shadow" href="<?php echo $tshirtecommerce_designer_link; ?>"><?php echo $tshirtecommerce_button_custom_your_design; ?></a>
						</p>
					<?php }
				} ?>
			
                    <button type="button" id="button-cart" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary radius-2x shadow">
                      <i class="zmdi zmdi-mall"></i><span><?php echo $button_cart; ?></span>
                    </button>
                </div> 
                <div class="pull-left space-right-10">
                    <a data-toggle="tooltip" class="btn btn-sm btn-inverse-light radius-x" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product_id; ?>');"><i class="zmdi zmdi-refresh-alt"></i></a>
                </div>
                <div class="pull-left">  
                    <a data-toggle="tooltip" class="btn btn-sm btn-inverse-light radius-x" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product_id; ?>');"><i class="zmdi zmdi-favorite-outline zmdi-hc-fw"></i></a>
                </div>
               
              </div>  
              <?php if ($minimum > 1) { ?>
              <div class="alert alert-info space-top-10"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
              <?php } ?>
              </div>
                <!-- AddThis Button BEGIN -->
                <div class="addthis_toolbox addthis_default_style" data-url="<?php echo $share; ?>"><a class="addthis_button_facebook_like" fb:like:layout="button_count"></a> <a class="addthis_button_tweet"></a> <a class="addthis_button_pinterest_pinit"></a> <a class="addthis_counter addthis_pill_style"></a></div>
                <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-515eeaf54693130e"></script>
                <!-- AddThis Button END -->
              </div>
               
          <?php require( ThemeControlHelper::getLayoutPath( 'product/info/'.$layout_pinfo.'.tpl' ) );  ?>
          </div>

        </div>
      </div>

      <?php if ($products) {  $heading_title = $text_related; $customcols = 4; ?>
        <div class="panel panel-center product-related"> <?php require( ThemeControlHelper::getLayoutPath( 'common/products_carousel.tpl' ) );  ?>   </div>
      <?php } ?>

      <?php if ($tags) { ?>
      <p><?php echo $text_tags; ?>
        <?php for ($i = 0; $i < count($tags); $i++) { ?>
        <?php if ($i < (count($tags) - 1)) { ?>
        <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
        <?php } else { ?>
        <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
        <?php } ?>
        <?php } ?>
      </p>
      <?php } ?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<script type="text/javascript"><!--
$('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
	$.ajax({
		url: 'index.php?route=product/product/getRecurringDescription',
		type: 'post',
		data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#recurring-description').html('');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();

			if (json['success']) {
				$('#recurring-description').html(json['success']);
			}
		}
	});
});
//--></script>
<script type="text/javascript"><!--
$('#button-cart').on('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-cart').button('loading');
		},
		complete: function() {
			$('#button-cart').button('reset');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');

			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						var element = $('#input-option' + i.replace('_', '-'));

						if (element.parent().hasClass('input-group')) {
							element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						} else {
							element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						}
					}
				}

				if (json['error']['recurring']) {
					$('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
				}

				// Highlight any found errors
				$('.text-danger').parent().addClass('has-error');
			}

			if (json['success']) {
				$('#notification').html('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
		          
//				alert(json['total']);
//				$('#cart-total').html(json['total']);
		        res = json['total'].split("-"); 
  				$('#text-items').html(res[1]);
  				var out = json['total'].substr(0,json['total'].indexOf(' '));
  				$('#cart-total').html(out);
				$('html, body').animate({ scrollTop: 0 }, 'slow');
				
				$('#cart > ul').load('index.php?route=common/cart/info ul li');
			}
		}
	});
});
//--></script> 
<script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});

$('.datetime').datetimepicker({
	pickDate: true,
	pickTime: true
});

$('.time').datetimepicker({
	pickDate: false
});

$('button[id^=\'button-upload\']').on('click', function() {
	var node = this;

	$('#form-upload').remove();

	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

	$('#form-upload input[name=\'file\']').trigger('click');

	if (typeof timer != 'undefined') {
    	clearInterval(timer);
	}

	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);

			$.ajax({
				url: 'index.php?route=tool/upload',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					$(node).button('loading');
				},
				complete: function() {
					$(node).button('reset');
				},
				success: function(json) {
					$('.text-danger').remove();

					if (json['error']) {
						$(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
					}

					if (json['success']) {
						alert(json['success']);

						$(node).parent().find('input').attr('value', json['code']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});
//--></script>
<script type="text/javascript"><!--
$('#review').delegate('.pagination a', 'click', function(e) {
    e.preventDefault();

    $('#review').fadeOut('slow');

    $('#review').load(this.href);

    $('#review').fadeIn('slow');
});

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').on('click', function() {
  $.ajax({
    url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
    type: 'post',
    dataType: 'json',
    data: $("#form-review").serialize(),
    beforeSend: function() {
      $('#button-review').button('loading');
    },
    complete: function() {
      $('#button-review').button('reset');
    },
    success: function(json) {
      $('.alert-success, .alert-danger').remove();

      if (json['error']) {
        $('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
      }

      if (json['success']) {
        $('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');

        $('input[name=\'name\']').val('');
        $('textarea[name=\'text\']').val('');
        $('input[name=\'rating\']:checked').prop('checked', false);
      }
    }
  });
});

$(document).ready(function() { 
  $('.thumbnail a').click(
    function(){  
      $.magnificPopup.open({
        items: {
          src:  $('img',this).attr('src')
        },
        type: 'image'
      }); 
      return false;
    }
  );
});
//--></script> 
<?php if( $productConfig['product_enablezoom'] ) { ?>
<script type="text/javascript" src=" catalog/view/javascript/jquery/elevatezoom/elevatezoom-min.js"></script>
<script type="text/javascript">
    var zoomCollection = '<?php echo $productConfig["product_zoomgallery"]=="basic"?".product-image-zoom":"#image";?>';
    $( zoomCollection ).elevateZoom({
    <?php if( $productConfig['product_zoommode'] != 'basic' ) { ?>
    zoomType        : "<?php echo $productConfig['product_zoommode'];?>",
    <?php } ?>
    lensShape : "<?php echo $productConfig['product_zoomlensshape'];?>",
    lensSize    : <?php echo (int)$productConfig['product_zoomlenssize'];?>,
    easing:true,
    gallery:'image-additional-carousel',
    cursor: 'pointer',
    galleryActiveClass: "active"
  });
 
</script>
<?php } else { ?>
<script type="text/javascript">
$(document).ready(function() {
  $('.thumbnails').magnificPopup({
    type:'image',
    delegate: 'a',
    gallery: {
      enabled:true
    }
  });
});
</script>
<?php } ?>
<?php echo $footer; ?>

