<?php
class ControllerExtensionModuleFeatured extends Controller {
	public function index($setting) {
		$this->load->language('extension/module/featured');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_tax'] = $this->language->get('text_tax');

		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		$data['products'] = array();

		if (!$setting['limit']) {
			$setting['limit'] = 4;
		}

		if (!empty($setting['product'])) {
			$products = array_slice($setting['product'], 0, (int)$setting['limit']);

			foreach ($products as $product_id) {
				$product_info = $this->model_catalog_product->getProduct($product_id);

				if ($product_info) {
					if ($product_info['image']) {
						$image = $this->model_tool_image->resize($product_info['image'], $setting['width'], $setting['height']);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
					}

					if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$price = false;
					}

					if ((float)$product_info['special']) {
						$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$special = false;
					}

					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price'], $this->session->data['currency']);
					} else {
						$tax = false;
					}

					if ($this->config->get('config_review_status')) {
						$rating = $product_info['rating'];
					} else {
						$rating = false;
					}


				$customize_link = '';
				$product_design_id = '';
				$parent_id = $product_info['product_id'];
				$this->load->model('setting/setting');
				$settings = $this->model_setting_setting->getSetting('tshirtecommerce');
				if (isset($settings['tshirtecommerce_feature']) && $settings['tshirtecommerce_feature'] == 1) {
					$query16635 = $this->db->query("
						SELECT `design_product_id` 
						FROM `".DB_PREFIX."product` 
						WHERE `product_id` = ".$product_info['product_id'] ." LIMIT 1
					");
					$product_design_id = $query16635->row['design_product_id'];
					if ($product_design_id != false && !empty($product_design_id) && $parent_id > 0) {
						$customize_link = 'index.php?route=tshirtecommerce/designer&product_id='.$product_design_id.'&parent_id='.$parent_id;
					}
				}
				if (!defined('DS')) define('DS', DIRECTORY_SEPARATOR);
				if (!defined('ROOT')) define('ROOT', dirname(DIR_SYSTEM).DIRECTORY_SEPARATOR.'tshirtecommerce');
				$tshirtecommerce_custom_button_text = '';
				if (file_exists(ROOT.DS.'includes'.DS.'functions.php')) {
					include_once ROOT.DS.'includes'.DS.'functions.php';
					include_once ROOT.DS.'includes'.DS.'addons.php';
					$addons = new addons();
					$dg = new dg();
					$lang = $dg->lang();
					$tshirtecommerce_custom_button_text = $addons->__('tshirtecommerce_custom_button_text');
				}
			

                
                if (!defined('DS')) define('DS', DIRECTORY_SEPARATOR);
				if (!defined('ROOT')) define('ROOT', dirname(DIR_SYSTEM).DS.'tshirtecommerce');
                include(ROOT.'/opencart/includes/product_featured.php');
			
            
					$data['products'][] = array(

				'customize_link' => $customize_link,
				'tshirtecommerce_custom_button_text' => $tshirtecommerce_custom_button_text,
			
						'product_id'  => $product_info['product_id'],
						'thumb'       => $image,
						'name'        => $product_info['name'],
						'description' => utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
						'price'       => $price,
						'special'     => $special,
						'tax'         => $tax,
						'rating'      => $rating,
						'href'        => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])
					);
				}
			}
		}

		if ($data['products']) {
			return $this->load->view('extension/module/featured', $data);
		}
	}
}