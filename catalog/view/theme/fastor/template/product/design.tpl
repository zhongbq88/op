<?php echo $header; 
$theme_options = $registry->get('theme_options');
$config = $registry->get('config');
$page_direction = $theme_options->get( 'page_direction' ); 
$background_status = false;
$product_page = true;
include('catalog/view/theme/'.$config->get('theme_' . $config->get('config_theme') . '_directory').'/template/new_elements/wrapper_top.tpl'); ?>

<div class="htmleaf-container" >
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <input type="file" multiple id="ssi-upload"/>
      </div>
    </div>
  </div>
</div>

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
	var baseurl = <?php echo json_encode($baseurl); ?>;
	var info_dsign = <?php echo json_encode($design_info); ?>;
	var front_design = <?php echo str_replace("px","",$design_info['design']['front'][0]);?>;
	var design_product_id = <?php echo $product_id; ?>;
	var area_design = <?php echo str_replace("px","",$design_info['design']['area']['front']); ?>;
	var qty = <?php echo $minimum; ?>;
	var thmb = "<?php echo $thumb; ?>";
	$('#ssi-upload').ssi_uploader({url:'/tshirtecommerce/ajax.php?type=upload&remove=0',maxFileSize:6,siteURL:baseurl,thumb:thmb,allowed:['jpg','gif','png'],design:{front:front_design['1'],area:area_design,product_id:design_product_id,design_info:info_dsign,quantity:qty}}); 
	</script>
<style>
.breadcrumb{
	display:none;
}
.megamenuToogle-wrapper{
display:none;
}
</style>