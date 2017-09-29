</div>
<?php
  $blockid = 'mass_bottom';
  $blockcls = '';
 
  $ospans = array(1=>12);
  $tmcols = 'col-sm-12 col-xs-12';
  require( ThemeControlHelper::getLayoutPath( 'common/block-cols.tpl' ) );

  $defaultFooter = false;

  $themeConfig = (array)$sconfig->get('themecontrol');
  $fullwidth = isset($themeConfig['footer'])?$themeConfig['footer']:'';
  $class = '';
  if($fullwidth == "fullwidth"){
      $class = '-full';
  }
?>
<?php if( $defaultFooter ) { ?>

<footer>
  <div class="container">
    <div class="row">
      <?php if ($informations) { ?>
      <div class="col-sm-3">
        <h5><?php echo $text_information; ?></h5>
        <ul class="list-unstyled">
          <?php foreach ($informations as $information) { ?>
          <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
          <?php } ?>
        </ul>
      </div>
      <?php } ?>
      <div class="col-sm-3">
        <h5><?php echo $text_service; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
          <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
          <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
        </ul>
      </div>
      <div class="col-sm-3">
        <h5><?php echo $text_extra; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
          <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
          <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
          <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
        </ul>
      </div>
      <div class="col-sm-3">
        <h5><?php echo $text_account; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
          <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
          <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
          <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
        </ul>
      </div>
    </div>   
  </div>
</footer>
<?php } else { ?>

<footer id="footer" class="nostylingboxs">
  <?php
    $blockid = 'footer_top';
    $blockcls = '';
    $ospans = array(1=>12,2=>12);
    require( ThemeControlHelper::getLayoutPath( 'common/block-footcols.tpl' ) );
  ?>
  <img class="img-responsive space-padding-lr-3" src="image/catalog/divided.jpg" alt="">
  <?php

    $blockid = 'footer_center';
    $blockcls = '';
    $ospans = array(1=>4,2=>4,3=>4);
   
      require( ThemeControlHelper::getLayoutPath( 'common/block-footcols.tpl' ) );

      if( count($modules) <=0 ){
        $footer_layout = $helper->getConfig('footer_layout','theme');
        if($footer_layout == "default") {
          require( ThemeControlHelper::getLayoutPath( 'common/footer/default.tpl' ) );
        } else {
          require( ThemeControlHelper::getLayoutPath( 'common/footer/footer_center.tpl' ) );
        }
      }
  ?>

  <?php
    $blockid = 'footer_bottom';
    $blockcls = '';
    $ospans = array();
    require( ThemeControlHelper::getLayoutPath( 'common/block-footcols.tpl' ) );
  ?>


</footer>

<?php } ?>
<div class="copyright">
  <div class="container clearfix">
    <div class="inner border-top">
    <div class="col-lg-7 col-md-7 space-margin-l-15">
      <span class="copy pull-left space-margin-r-10"> 
       <?php if( $helper->getConfig('enable_custom_copyright', 0) ) { ?>
          <?php echo html_entity_decode($helper->getConfig('copyright')); ?>
        <?php } else { ?>
          <?php echo $powered; ?>. 
        <?php } ?>
      </span>
      <ul class="list-inline pull-left">
        <?php foreach ($informations as $information) { ?>
          <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
    <div class="col-lg-5 col-md-5 payment">
      <?php if( $content=$helper->getLangConfig('widget_payment') ) {?>
          <?php echo $content; ?>
      <?php } ?>
    </div>
    </div>
   
  </div>
</div>
<div id="top-scroll" class="bo-social-icons">
    <a href="#" class="bo-social-gray radius-x scrollup"><i class="fa fa-angle-up"></i></a>
  </div>
<?php if( $helper->getConfig('enable_paneltool',0) ){  ?>
  <?php  echo $helper->renderAddon( 'panel' );?>
<?php } ?>
<?php
  $offcanvas = $helper->getConfig('offcanvas','category');
  if($offcanvas == "megamenu") {
      echo $helper->renderAddon( 'offcanvas');
  } else {
      echo $helper->renderAddon( 'offcanvas-category');
  }

  ?> 
<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->

<!-- Theme created by Welford Media for OpenCart 2.0 www.welfordmedia.co.uk -->
</div>
</body></html>