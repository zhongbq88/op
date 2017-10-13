<?php echo $header; ?>

<div class="htmleaf-container" >
  <div class="container">
    <div class="row">
      <div class="col-md-12">
      <?php if(count($products)>0){?>
        <input type="file" multiple id="ssi-upload"/>
        <?php }?>
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
<script src="/catalog/view/theme/fastor/js/ssi-uploaderm.js"></script> 
<script type="text/javascript">
	var baseurl = <?php echo json_encode($baseurl); ?>;
	var size = <?php echo count($products)*4 ?>;
	if(size>0){
		var count = 4;
		var info_dsign = <?php echo json_encode($products); ?>;
		$('#ssi-upload').ssi_uploader({url:'/tshirtecommerce/ajax.php?type=upload&remove=0',maxFileSize:size,uploadSize:count,siteURL:baseurl,allowed:['jpg','gif','png'],products:info_dsign}); 
	}
	
	$(document).ready(function(){
		var width = $(window).width();
		if(width<=500){
			$('.megamenuToogle-wrapper').attr('style','display:none;');
			$('.logo').attr('style','display:none;');
			$('#header-center.col-sm-4').attr('style','display:none;');
			$('#header-right.col-sm-4').attr('style','height:0px;');
			$('.dropdown').attr('style','height:20px;');
			$('.my-account').attr('style','height:20px;');
			$('.ssi-buttonWrapper').attr('style','float: left;padding:8px ;z-index:999;bottom:0;position:fixed;');
			//$('.ssi-buttonSaveWrapper').attr('style','float:right;padding:8px ;z-index:999;bottom:0;position:fixed;');
		}
		//console.log(info_dsign[0].front.img);
	});
	</script>
<style>
.breadcrumb{
	display:none;
}
/*.megamenuToogle-wrapper{
display:none;
}*/
</style>