<?php 

// Since version 4.2.0
// For admin ajax
// - Quick setup

class ControllerTshirtecommerceAjax extends Controller
{
	public function tool()
	{
		$json = array('error' => 0, 'msg' => 'success');

		if (!defined('DS')) define('DS', DIRECTORY_SEPARATOR);
		if (!defined('ROOT')) define('ROOT', dirname(DIR_SYSTEM).DS.'tshirtecommerce');
		include_once ROOT.'/includes/functions.php';
		$dg = new dg();

		// write data layouts
		$layouts_json = ROOT.'/data/layouts.json';
		$is_change = false;

		if (isset($this->request->post['layout']) && file_exists($layouts_json)) {
			$layouts = $dg->getLayouts();

			if ($layouts !== false && count($layouts)) {
				foreach ($layouts as $key => &$value) {
					if ($value['theme'] == $this->request->post['layout']) {
						$value['default'] 	= 1;
						$is_change 			= true;
					} else {
						$value['default'] = 0;
					}
				}
			}
		}
		if ($is_change === true) {
			$dg->WriteFile($layouts_json, json_encode($layouts));
		}

		// write data languages
		$is_change = false;
		$languages_json = ROOT.'/data/languages.json';

		if (isset($this->request->post['language']) && file_exists($languages_json)) {
			$languages = @json_decode(@file_get_contents($languages_json), true);

			if ($languages !== false && count($languages) > 0) {
				foreach ($languages as $key => &$value) {
					if ($value['code'] == $this->request->post['language']) {
						$value['default'] = 1;
						$is_change = true;
					} else {
						$value['default'] = 0;
					}
				}
			}
		}
		if ($is_change === true) {
			$dg->WriteFile($languages_json, json_encode($languages));
		}

		$this->response->setOutput(@json_encode($json));
	}

	public function clipart()
	{
		$json = array('error' => 0, 'msg' => 'success');

		if (!defined('DS')) define('DS', DIRECTORY_SEPARATOR);
		if (!defined('ROOT')) define('ROOT', dirname(DIR_SYSTEM).DS.'tshirtecommerce');
		include_once ROOT.'/includes/functions.php';
		$dg = new dg();

		$setting_json = ROOT.'/data/settings.json';

		$settings = $dg->getSetting();
		if (isset($this->request->post['api_key']) && file_exists($setting_json) && $settings !== false && count($settings)) {
			$settings->store->api 			= trim($this->request->post['api_key']);
			$settings->store->verified 		= 0;
			$settings->store->auto_download = 0;
			$settings->store->your_clipart 	= 0;
			$settings->store->exchange_rate = 0.2;
			$settings->store->enable 		= 1;

			$url 	= 'http://api.9file.net/api/key/api_key/'.$settings->store->api;     
            $info 	= json_decode($this->openURL($url));

            $settings->store->verified = isset($info->error) ? 0 : 1;

            $write = $dg->WriteFile($setting_json, json_encode($settings));
            if ($write === true) {
                if( isset($settings->store) && isset($settings->store->api) && $settings->store->api != '' && isset($settings->store->verified) 
                	&& $settings->store->verified == 1 && isset($settings->store->enable) && $settings->store->enable == 1) {
                    include_once(ROOT.DS.'api.php');
                    $api = new API($settings->store->api);

                    $api->updateArts();
                    $api->updateIdeas();
                }
                $json['error'] = 0;
                $json['msg'] = 'The data synchronization is successful.';
            } else {
                $json['error'] = 1;
                $json['msg'] = sprintf('Can not write file %s.', $setting_json);
            }
		}

		$this->response->setOutput(@json_encode($json));
	}

	public function import()
	{
		$json = array('error' => 0, 'msg' => 'success');

		if (!defined('DS')) define('DS', DIRECTORY_SEPARATOR);
		if (!defined('ROOT')) define('ROOT', dirname(DIR_SYSTEM).DS.'tshirtecommerce');
		include_once ROOT.'/includes/functions.php';
		$dg = new dg();

		$file 		= 'http://updates.tshirtecommerce.com/products_import.zip';
		$packages 	= $this->openURL($file);
	    $new 		= ROOT.'/products_import'.time().'.zip';

	    if ($packages !== false && @file_put_contents($new, $packages)) {

	        if ($this->zipExtract($new, dirname(DIR_SYSTEM))) {
	            $json['error'] 	= 0;
	            $json['msg'] 	= 'Download and extract datas success.';
	            $json['log'] 	= 'Download and extract datas success.';
	        } else {
	            $json['error'] 	= 1;
	            $json['msg'] 	= 'Can not extract file on root. Please check permission again.';
	            $json['log'] 	= 'Can not extract file on root. Please check permission again.';
	        }
	    } else {
	        $json['error'] 	= 1;
	        $json['msg'] 	= 'Can not download demo package datas.';
	        $json['log'] 	= 'Can not download demo package datas.';
	    }

	    $this->load->model('catalog/product');

	    $this->load->model('localisation/language');
		$languages = $this->model_localisation_language->getLanguages();

		$demo_products = $dg->getProducts();

		if ($demo_products !== false && count($demo_products)) {
			foreach ($demo_products as $idx => $demo) {
				foreach ($languages as $language) {
					$data['product_description'][$language['language_id']] = array(
						'name' 				=> $demo->title,
						'description' 		=> $demo->description,
						'meta_title' 		=> $demo->title,
						'meta_description' 	=> $demo->title,
						'meta_keyword' 		=> $demo->title,
						'tag' 				=> $demo->title
					);
				}
				$data['model'] 		= 'TSHIRTDEMO'.$idx;
				$data['sku'] 		= $demo->sku;
				$data['upc'] 		= '';
				$data['ean'] 		= '';
				$data['jan'] 		= '';
				$data['isbn'] 		= '';
				$data['mpn'] 		= '';
				$data['location'] 	= '';

				$this->load->model('setting/store');
				$data['stores'] = $this->model_setting_store->getStores();

				$data['product_store'] 	= array(0);
				$data['keyword'] 		= str_replace(' ', '-', $demo->title);
				$data['shipping'] 		= 1;
				$data['price'] 			= $demo->price;

				$this->load->model('catalog/recurring');
				$data['recurrings'] = $this->model_catalog_recurring->getRecurrings();

				$data['product_recurrings'] = array();

				$this->load->model('localisation/tax_class');
				$data['tax_classes'] = $this->model_localisation_tax_class->getTaxClasses();

				$data['tax_class_id'] 	= 0;
				$data['date_available'] = date('Y-m-d');
				$data['quantity'] 		= (isset($demo->max_order) && !empty($demo->max_order) && $demo->max_order > 0) ? $demo->max_order : 9999;
				$data['minimum'] 		= (isset($demo->min_order) && !empty($demo->min_order) && $demo->min_order > 0) ? $demo->min_order : 1;
				$data['subtract'] 		= 1;
				$data['sort_order'] 	= 1;

				$this->load->model('localisation/stock_status');
				$data['stock_statuses'] = $this->model_localisation_stock_status->getStockStatuses();

				$data['stock_status_id'] 	= 0;
				$data['status'] 			= true;
				$data['weight'] 			= '';

				$this->load->model('localisation/weight_class');
				$data['weight_classes'] 	= $this->model_localisation_weight_class->getWeightClasses();
				$data['weight_class_id'] 	= $this->config->get('config_weight_class_id');

				$data['length'] = '';
				$data['width'] 	= '';
				$data['height'] = '';

				$this->load->model('localisation/length_class');
				$data['length_classes'] 	= $this->model_localisation_length_class->getLengthClasses();
				$data['length_class_id'] 	= $this->config->get('config_length_class_id');
				$this->load->model('catalog/manufacturer');
				$data['manufacturer_id'] 	= 0;
				$data['manufacturer'] 		= '';
				$data['product_categories'] = array();
				$data['product_filters'] 	= array();
				$data['product_attributes'] = array();
				$data['product_options'] 	= array();
				$data['option_values'] 		= array();
				$this->load->model('customer/customer_group');
				$data['customer_groups'] 	= $this->model_customer_customer_group->getCustomerGroups();
				$data['product_discounts'] 	= array();
				$data['product_specials'] 	= array();
				

				// Get image from demo
				$source = $demo->image; // is url
				$name 	= 'catalog/demo_tshirtecommerce_thumb'.uniqid(time()).'.png';
				$dest 	= DIR_IMAGE.'/'.$name;
				//copy($source, $dest);
				if ($this->openURL($source) !== false) {
					@file_put_contents($dest, $this->openURL($source));
				}

				$data['image'] = $name;
				$demo_images = array();
				if (isset($demo->design)) {
					if (isset($demo->design->front) && count($demo->design->front)) {
						foreach ($demo->design->front as $k => $v) {
							if (!empty($v)) {
								$v 		= str_replace("'", '"', $v);
								$temp 	= json_decode($v, true);

								if (isset($temp[1]) && isset($temp[1]['img'])) {
									$s = dirname(DIR_SYSTEM).'/tshirtecommerce/'.$temp[1]['img'];
									$n = 'catalog/demo_tshirtecommerce_f'.$k.uniqid(time()).'.png';
									$d = DIR_IMAGE.'/'.$n;
									@copy($s, $d);
									$demo_images[] = $n;
								}
							}
						}
					}
					if (isset($demo->design->back) && count($demo->design->back)) {
						foreach ($demo->design->back as $k => $v) {
							if (!empty($v)) {
								$v 		= str_replace("'", '"', $v);
								$temp 	= json_decode($v, true);

								if (isset($temp[1]) && isset($temp[1]['img'])) {
									$s = dirname(DIR_SYSTEM).'/tshirtecommerce/'.$temp[1]['img'];
									$n = 'catalog/demo_tshirtecommerce_b'.$k.uniqid(time()).'.png';
									$d = DIR_IMAGE.'/'.$n;
									@copy($s, $d);
									$demo_images[] = $n;
								}
							}
						}
					}
					if (isset($demo->design->left) && count($demo->design->left)) {
						foreach ($demo->design->left as $k => $v) {
							if (!empty($v)) {
								$v 		= str_replace("'", '"', $v);
								$temp 	= json_decode($v, true);

								if (isset($temp[1]) && isset($temp[1]['img'])) {
									$s = dirname(DIR_SYSTEM).'/tshirtecommerce/'.$temp[1]['img'];
									$n = 'catalog/demo_tshirtecommerce_l'.$k.uniqid(time()).'.png';
									$d = DIR_IMAGE.'/'.$n;
									@copy($s, $d);
									$demo_images[] = $n;
								}
							}
						}
					}
					if (isset($demo->design->right) && count($demo->design->right)) {
						foreach ($demo->design->right as $k => $v) {
							if (!empty($v)) {
								$v 		= str_replace("'", '"', $v);
								$temp 	= json_decode($v, true);

								if (isset($temp[1]) && isset($temp[1]['img'])) {
									$s = dirname(DIR_SYSTEM).'/tshirtecommerce/'.$temp[1]['img'];
									$n = 'catalog/demo_tshirtecommerce_r'.$k.uniqid(time()).'.png';
									$d = DIR_IMAGE.'/'.$n;
									@copy($s, $d);
									$demo_images[] = $n;
								}
							}
						}
					}
				}

				$data['product_image'] = array();
				if (count($demo_images)) {
					foreach ($demo_images as $key => $value) {
						$data['product_image'][] = array(
							'image'      => $value,
							'sort_order' => $key
						);
					}
				}

				$data['product_downloads'] 	= array();
				$data['product_relateds'] 	= array();
				$data['points'] 			= '';
				$data['product_reward'] 	= array();
				$data['product_layout'] 	= array();

				$this->load->model('design/layout');
				$data['layouts'] = $this->model_design_layout->getLayouts();

				// Insert opencart demo data
				$product_id = $this->model_catalog_product->addProduct($data);

				// Insert tshirtecommerce demo data
				if ($product_id !== false && $product_id > 0 && $demo->id > 0) {
					$this->db->query('UPDATE `'.DB_PREFIX.'product` SET `design_product_id` = '.$demo->id.' WHERE `product_id` = '.(int)$product_id);
				}
			}
		}

		$this->response->setOutput(@json_encode($json));
	}

	public function finish()
	{
		$json = array('error' => 0, 'msg' => 'success');
		$this->response->setOutput(@json_encode($json));
	}

	protected function zipExtract($from_file, $to_dir)
    {
        if (!file_exists($to_dir)) mkdir($to_dir, 0777);

        // Unzip the files
		$zip = new ZipArchive();

		if ($zip->open($from_file)) {
			$zip->extractTo($to_dir);
			$zip->close();
		} else {
			return false;
		}

		// Remove Zip
		unlink($from_file);

        return true;
    }

    protected function fnStrtolower($str)
	{
		if (is_array($str)) {
	            return false;
	        }
	        if (function_exists('mb_strtolower')) {
	            return mb_strtolower($str, 'utf-8');
	        }
	        return strtolower($str);
	}

	protected function openURL($url, $use_include_path = false, $stream_context = null, $curl_timeout = 5)
	{
	    if ($stream_context == null && preg_match('/^https?:\/\//', $url)) {
	        $stream_context = @stream_context_create(array('http' => array('timeout' => $curl_timeout)));
	    }
	    if (in_array(ini_get('allow_url_fopen'), array('On', 'on', '1')) || !preg_match('/^https?:\/\//', $url)) {
	        return @file_get_contents($url, $use_include_path, $stream_context);
	    } elseif (function_exists('curl_init')) {
	        $curl = curl_init();
	        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
	        curl_setopt($curl, CURLOPT_URL, $url);
	        curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);
	        curl_setopt($curl, CURLOPT_TIMEOUT, $curl_timeout);
	        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0);
	        if ($stream_context != null) {
	            $opts = stream_context_get_options($stream_context);
	            if (isset($opts['http']['method']) && $this->fnStrtolower($opts['http']['method']) == 'post') {
	                curl_setopt($curl, CURLOPT_POST, true);
	                if (isset($opts['http']['content'])) {
	                    parse_str($opts['http']['content']);
	                    curl_setopt($curl, CURLOPT_POSTFIELDS, array());
	                }
	            }
	        }
	        $content = curl_exec($curl);
	        curl_close($curl);
	        return $content;
	    } else {
	        return false;
	    }
	}
}

?>