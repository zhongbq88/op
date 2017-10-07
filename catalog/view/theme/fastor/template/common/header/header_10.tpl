
<?php if($theme_options->get( 'fixed_header' ) == 1) { ?>
<!-- HEADER
	================================================== -->
<div class="fixed-header-1 sticky-header header-type-3 header-type-10">
	<div class="background-header"></div>
	<div class="slider-header">
		<!-- Top of pages -->
		<div id="top" class="<?php if($theme_options->get( 'header_layout' ) == 1) { echo 'full-width'; } elseif($theme_options->get( 'header_layout' ) == 4) { echo 'fixed3 fixed2'; } elseif($theme_options->get( 'header_layout' ) == 3) { echo 'fixed2';  } else { echo 'fixed'; } ?>">
			<div class="background-top"></div>
			<div class="background">
				<div class="shadow"></div>
				<div class="pattern">
					<div class="container">
						<div class="row">		
						     <?php if ($logo) { 
						     $nthumb = str_replace(' ', "%20", ($logo));
						     $nthumb = str_replace(HTTP_SERVER, "", $nthumb);
						     $image_size = getimagesize($nthumb); ?>
						     <!-- Header Left -->
						     <div class="col-sm-4" id="header-left" style="min-width: <?php echo $image_size[0]+55; ?>px">
						          <!-- Logo -->
						          <div class="logo"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
						     </div>
						     <?php } ?>
						     
							<!-- Header Left -->
							<div class="col-sm-4" id="header-center">
	                                    <?php 
	                                    $menu = $modules_old_opencart->getModules('menu');
	                                    if( count($menu) ) { ?>
	                                         <div class="megamenu-background">
	                                              <div class="">
	                                                   <div class="overflow-megamenu container">
	                                    				<?php 
	                                    				if(count($menu) > 1) echo '<div class="row mega-menu-modules">';
	                                    				$i = 0;
	                                    				    
	                                    				foreach ($menu as $module) {
	                                    				     if($i == 0 && count($menu) > 1) echo '<div class="col-md-3">';
	                                    				     if($i == 1 && count($menu) > 1) echo '<div class="col-md-9">';
	                                    					     echo $module;
	                                    					if(count($menu) > 1 && ($i == 0 || $i == 1)) echo '</div>';
	                                    					if(count($menu) > 1 && $i == 1) echo '</div>';
	                                    					$i++;
	                                    				} ?>
	                                    			</div>
	                                    		</div>
	                                    	</div>
	                                    <?php
	                                    }
	                                    ?>
							</div>
							
							<!-- Header Right -->
							<div class="col-sm-4" id="header-right">
							     <?php 
							     $top_block = $modules_old_opencart->getModules('top_block');
							     if( count($top_block) ) { 
							     	foreach ($top_block as $module) {
							     		echo $module;
							     	}
							     } ?>
							     
							     <?php echo $currency.$language; ?>
							     <?php echo $cart; ?>
							     	<?php if ($logged) { ?>
							     		<div class="my-account-with-logout">
							     			<a href="<?php echo $account; ?>" onclick="window.location.href = '<?php echo $account; ?>'" class="my-account" data-hover="dropdown" data-toggle="dropdown"><i class="fa fa-user"></i></a>
							     			<ul class="dropdown-menu">
							     				<li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
							     				<li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
							     			</ul>
							     		</div>
							     	<?php } else { ?>
							     		<a href="<?php echo $account; ?>" class="my-account"><i class="fa fa-user"></i></a>
							     	<?php } ?>
							     <!-- Search --><div class="search_form"><i class="fa fa-search"></i></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<?php } ?>

<!-- HEADER
	================================================== -->
<header class="header-type-3 header-type-10">
	<div class="background-header"></div>
	<div class="slider-header">
		<!-- Top of pages -->
		<div id="top" class="<?php if($theme_options->get( 'header_layout' ) == 1) { echo 'full-width'; } elseif($theme_options->get( 'header_layout' ) == 4) { echo 'fixed3 fixed2'; } elseif($theme_options->get( 'header_layout' ) == 3) { echo 'fixed2';  } else { echo 'fixed'; } ?>">
			<div class="background-top"></div>
			<div class="background">
				<div class="shadow"></div>
				<div class="pattern">
					<div class="container">
						<div class="row">		
						     <?php if ($logo) { 
						     $nthumb = str_replace(' ', "%20", ($logo));
						     $nthumb = str_replace(HTTP_SERVER, "", $nthumb);
						     $image_size = getimagesize($nthumb); ?>
						     <!-- Header Left -->
						     <div class="col-sm-4" id="header-left" style="min-width: <?php echo $image_size[0]+55; ?>px">
						          <!-- Logo -->
						          <div class="logo"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
						     </div>
						     <?php } ?>
						     
							<!-- Header Left -->
							<div class="col-sm-4" id="header-center">
                                        <?php 
                                        $menu = $modules_old_opencart->getModules('menu');
                                        if( count($menu) ) { ?>
                                             <div class="megamenu-background">
                                                  <div class="">
                                                       <div class="overflow-megamenu container">
                                        				<?php 
                                        				if(count($menu) > 1) echo '<div class="row mega-menu-modules">';
                                        				$i = 0;
                                        				    
                                        				foreach ($menu as $module) {
                                        				     if($i == 0 && count($menu) > 1) echo '<div class="col-md-3">';
                                        				     if($i == 1 && count($menu) > 1) echo '<div class="col-md-9">';
                                        					     echo $module;
                                        					if(count($menu) > 1 && ($i == 0 || $i == 1)) echo '</div>';
                                        					if(count($menu) > 1 && $i == 1) echo '</div>';
                                        					$i++;
                                        				} ?>
                                        			</div>
                                        		</div>
                                        	</div>
                                        <?php
                                        }
                                        ?>
							</div>
							
							<!-- Header Right -->
							<div class="col-sm-4" id="header-right">
							     <?php 
							     $top_block = $modules_old_opencart->getModules('top_block');
							     if( count($top_block) ) { 
							     	foreach ($top_block as $module) {
							     		echo $module;
							     	}
							     } ?>
							     
							     <?php echo $currency.$language; ?>
							     <?php echo $cart; ?>
							     	<?php if ($logged) { ?>
							     		<div class="my-account-with-logout">
							     			<a href="<?php echo $account; ?>" onclick="window.location.href = '<?php echo $account; ?>'" class="my-account" data-hover="dropdown" data-toggle="dropdown"><i class="fa fa-user"></i></a>
							     			<ul class="dropdown-menu">
							     				<li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
							     				<li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
							     			</ul>
							     		</div>
							     	<?php } else { ?>
							     		<a href="<?php echo $account; ?>" class="my-account"><i class="fa fa-user"></i></a>
							     	<?php } ?>
							     <!-- Search --><div class="search_form"><i class="fa fa-search"></i></div>
							</div>
						</div>
					</div>
					
					<?php 
					$menu2 = $modules_old_opencart->getModules('menu2');
					if( count($menu2) ) { 
					     echo '<div class="overflow-menu2">';
						foreach ($menu2 as $module) {
							echo $module;
						}
						echo '</div>';
					} ?>
				</div>
			</div>
		</div>
	</div>
	
	<?php $slideshow = $modules_old_opencart->getModules('slideshow'); ?>
	<?php  if(count($slideshow)) { ?>
	<!-- Slider -->
	<div id="slider" class="<?php if($theme_options->get( 'slideshow_layout' ) == 1) { echo 'full-width'; } elseif($theme_options->get( 'slideshow_layout' ) == 4) { echo 'fixed3 fixed2'; } elseif($theme_options->get( 'slideshow_layout' ) == 3) { echo 'fixed2'; } else { echo 'fixed'; } ?>">
		<div class="background-slider"></div>
		<div class="background">
			<div class="shadow"></div>
			<div class="pattern">
				<?php foreach($slideshow as $module) { ?>
				<?php echo $module; ?>
				<?php } ?>
			</div>
		</div>
	</div>
	<?php } ?>
</header>