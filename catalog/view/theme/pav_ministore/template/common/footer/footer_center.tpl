<div class="<?php echo str_replace('_','-',$blockid); ?> <?php echo $blockcls;?>" id="pavo-<?php echo str_replace('_','-',$blockid); ?>">
  <div class="container<?php echo $class; ?>">
    <div class="inside space-padding-tb-50">
       <div class="row">
        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 column">
        <?php if( $content=$helper->getLangConfig('widget_contact') ) {?>
              <?php echo $content; ?>
          <?php } ?>
        </div>
        <?php if ($informations) { ?>
        <div class="col-sm-2 col-md-2 col-sm-6 col-xs-12 column">
          <div class="panel panel-v1">
            <div class="panel-heading">
              <h4 class="panel-title"><?php echo $text_account; ?></h4>
            </div>
            <div class="panel-body">
              <ul class="list-unstyled">
                <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
                <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
                <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
                <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
                <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
              </ul>
            </div>
          </div>      
        </div>
        <?php } ?>
        <div class="column col-xs-12 col-sm-6 col-md-2 col-lg-2">
          <div class="panel panel-v1">
            <div class="panel-heading">
              <h4 class="panel-title"><?php echo $text_service; ?></h4>
            </div>
            <div class="panel-body">
              <ul class="list-unstyled">
                <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
                <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
                <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
                 <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
                <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
              </ul>
            </div>
          </div>
        </div>
        <div class="col-sm-2 col-md-2 col-sm-6 col-xs-12 column">
          <div class="panel panel-v1">
            <div class="panel-heading">
              <h4 class="panel-title"><?php echo $text_extra; ?></h4>
            </div>
            <div class="panel-body">
              <ul class="list-unstyled">
                <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
                <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
                <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
                <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
              </ul>
            </div>
          </div>            
        </div>
        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 column">
          <?php
            echo $helper->renderModule('pavnewsletter');
          ?>
        </div>
      </div>
    </div>
  </div>
</div>

