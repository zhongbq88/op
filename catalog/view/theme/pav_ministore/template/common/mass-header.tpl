<?php require( PAVO_THEME_DIR."/template/common/config_layout.tpl" );  ?>
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