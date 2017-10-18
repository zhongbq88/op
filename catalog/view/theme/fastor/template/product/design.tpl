<?php echo $header; ?>

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
	$('#ssi-upload').ssi_uploader({url:'/tshirtecommerce/ajax.php?type=upload&remove=0',maxFileSize:10,siteURL:baseurl,allowed:['jpg', 'jpeg', 'png', 'bmp', 'gif'],design:{front:front_design['1'],area:area_design,product_id:design_product_id,design_info:info_dsign,quantity:qty}}); 
	$(document).ready(function(){
		var width = $(window).width();
		if(width<=500){
			$('.megamenuToogle-wrapper').attr('style','display:none;');
			$('.logo').attr('style','padding:7px;');
			$('.slider-header').attr('style','display:none;');
			$('#header-right.col-sm-4').attr('style','display:none;');
			$('#header-left.col-sm-4').attr('style','height: 45px;padding:0px');
			$('.dropdown').attr('style','height:20px;');
			$('.my-account').attr('style','height:20px;');
			$('.ssi-buttonWrapper').attr('style','float: left;padding:0px ;z-index:999;bottom:0;position:fixed;width:100%');
			$('#chooseBtn').attr('style','border-radius:0px;width:100%');
			//$('.ssi-buttonSaveWrapper').attr('style','float:right;padding:8px ;z-index:999;bottom:0;position:fixed;');
		}
		//console.log(width);
	});
	</script>
<style>
.breadcrumb{
	
	display:none;
}
/*.megamenu-background{
	display:none;
}*/
/*.megamenuToogle-wrapper{
display:none;
}*/
</style>