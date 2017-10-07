<?php
class ControllerCheckoutCart extends Controller {
	public function index() {
		$this->load->language('checkout/cart');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('common/home'),
			'text' => $this->language->get('text_home')
		);

		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('checkout/cart'),
			'text' => $this->language->get('heading_title')
		);

		if ($this->cart->hasProducts() || !empty($this->session->data['vouchers'])) {
<<<<<<< HEAD
			$data['heading_title'] = $this->language->get('heading_title');

			$data['text_recurring_item'] = $this->language->get('text_recurring_item');
			$data['text_next'] = $this->language->get('text_next');
			$data['text_next_choice'] = $this->language->get('text_next_choice');

			$data['column_image'] = $this->language->get('column_image');
			$data['column_name'] = $this->language->get('column_name');
			$data['column_model'] = $this->language->get('column_model');
			$data['column_quantity'] = $this->language->get('column_quantity');
			$data['column_price'] = $this->language->get('column_price');
			$data['column_total'] = $this->language->get('column_total');

			$data['button_update'] = $this->language->get('button_update');
			$data['button_remove'] = $this->language->get('button_remove');
			$data['button_shopping'] = $this->language->get('button_shopping');
			$data['button_checkout'] = $this->language->get('button_checkout');

=======
>>>>>>> 1c170fe64a36c3191167bac857d158e8ff3ecf46
			if (!$this->cart->hasStock() && (!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning'))) {
				$data['error_warning'] = $this->language->get('error_stock');
			} elseif (isset($this->session->data['error'])) {
				$data['error_warning'] = $this->session->data['error'];

				unset($this->session->data['error']);
			} else {
				$data['error_warning'] = '';
			}

			if ($this->config->get('config_customer_price') && !$this->customer->isLogged()) {
				$data['attention'] = sprintf($this->language->get('text_login'), $this->url->link('account/login'), $this->url->link('account/register'));
			} else {
				$data['attention'] = '';
			}

			if (isset($this->session->data['success'])) {
				$data['success'] = $this->session->data['success'];

				unset($this->session->data['success']);
			} else {
				$data['success'] = '';
			}

			$data['action'] = $this->url->link('checkout/cart/edit', '', true);

			if ($this->config->get('config_cart_weight')) {
				$data['weight'] = $this->weight->format($this->cart->getWeight(), $this->config->get('config_weight_class_id'), $this->language->get('decimal_point'), $this->language->get('thousand_point'));
			} else {
				$data['weight'] = '';
			}

			$this->load->model('tool/image');
			$this->load->model('tool/upload');

			$data['products'] = array();

<<<<<<< HEAD
=======

				/* Path: vqmod/xml/tshirtecommerce_product.xml */
				$this->load->model('tshirtecommerce/order');
			
>>>>>>> 1c170fe64a36c3191167bac857d158e8ff3ecf46
			$products = $this->cart->getProducts();

			foreach ($products as $product) {
				$product_total = 0;

				foreach ($products as $product_2) {
					if ($product_2['product_id'] == $product['product_id']) {
						$product_total += $product_2['quantity'];
					}
				}

				if ($product['minimum'] > $product_total) {
					$data['error_warning'] = sprintf($this->language->get('error_minimum'), $product['name'], $product['minimum']);
				}

				if ($product['image']) {
<<<<<<< HEAD
					$image = $this->model_tool_image->resize($product['image'], $this->config->get($this->config->get('config_theme') . '_image_cart_width'), $this->config->get($this->config->get('config_theme') . '_image_cart_height'));
=======
					$image = $this->model_tool_image->resize($product['image'], $this->config->get('theme_' . $this->config->get('config_theme') . '_image_cart_width'), $this->config->get('theme_' . $this->config->get('config_theme') . '_image_cart_height'));
>>>>>>> 1c170fe64a36c3191167bac857d158e8ff3ecf46
				} else {
					$image = '';
				}

				$option_data = array();

				foreach ($product['option'] as $option) {
					if ($option['type'] != 'file') {
						$value = $option['value'];
					} else {
						$upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

						if ($upload_info) {
							$value = $upload_info['name'];
						} else {
							$value = '';
						}
					}

					$option_data[] = array(
						'name'  => $option['name'],
						'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
					);
				}

				// Display prices
				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$unit_price = $this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'));
					
					$price = $this->currency->format($unit_price, $this->session->data['currency']);
					$total = $this->currency->format($unit_price * $product['quantity'], $this->session->data['currency']);
				} else {
					$price = false;
					$total = false;
				}

				$recurring = '';

				if ($product['recurring']) {
					$frequencies = array(
						'day'        => $this->language->get('text_day'),
						'week'       => $this->language->get('text_week'),
						'semi_month' => $this->language->get('text_semi_month'),
						'month'      => $this->language->get('text_month'),
<<<<<<< HEAD
						'year'       => $this->language->get('text_year'),
=======
						'year'       => $this->language->get('text_year')
>>>>>>> 1c170fe64a36c3191167bac857d158e8ff3ecf46
					);

					if ($product['recurring']['trial']) {
						$recurring = sprintf($this->language->get('text_trial_description'), $this->currency->format($this->tax->calculate($product['recurring']['trial_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['trial_cycle'], $frequencies[$product['recurring']['trial_frequency']], $product['recurring']['trial_duration']) . ' ';
					}

					if ($product['recurring']['duration']) {
						$recurring .= sprintf($this->language->get('text_payment_description'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
					} else {
						$recurring .= sprintf($this->language->get('text_payment_cancel'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
					}
				}


<<<<<<< HEAD
				if (!defined('DS')) define('DS', DIRECTORY_SEPARATOR);
				if (!defined('ROOT')) define('ROOT', dirname(DIR_SYSTEM).DS.'tshirtecommerce');
				include_once ROOT.DS.'includes'.DS.'functions.php';
				include_once ROOT.DS.'includes'.DS.'addons.php';
				$addons = new addons();

				$data['tshirtecommerce_designer_cart_edit'] = $addons->__('designer_cart_edit');
				$data['tshirtecommerce_printing_type'] = $addons->__('tshirtecommerce_printing_type');
				if (isset($product['design']) && $product['design'] != false && isset($product['design']['rowid'])) {					
					$design = $product['design'];
					$item = $this->db->query("
						SELECT `product_id`, `design_product_id` 
						FROM `".DB_PREFIX."product` 
						WHERE `status` = 1 AND `product_id` = '".$product['design']['product_id']."'
					");
					$design_product_id = 0;
					if ($item->num_rows) $design_product_id = $item->row['design_product_id'];
					$keys = explode(':', $design_product_id);
					if (count($keys) > 1 && isset($keys[3]) && isset($design['color_hex'])) {
						$keys[3] = $design['color_hex'];
						$design_product_id = $keys[0].':'.$keys[1].':'.$keys[2].':'.$keys[3];
					}
					$product['design']['design_product_id'] = $design_product_id;

					if (isset($design['images'])) {
						$images = json_decode(str_replace('&quot;', '"', $design['images']), true);
						if (count($images) > 0) {
							$base_url = (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) ? $this->config->get('config_ssl') : $this->config->get('config_url');
							$img = '';
							foreach ($images as $view => $src) {
								$img .= '<a href="'.$base_url.'/tshirtecommerce/'.$src.'"><img style="width:100px; margin:1%;" src="'.$base_url.'/tshirtecommerce/'.$src.'" alt="" title="" class="img-thumbnail"></a>';
							}
							$design_option = array(
								'name'	=> 'Images',
								'value'	=> '<br /><div>'.$img.'</div>'
							);
							$option_data[] = $design_option;
						}
					}

					$design_option = array(
						'name' => 'Color',
						'value'	=> '<span title="'.$design['color_title'].'" style="background-color:#'.$design['color_hex'].';display:inline-block;border:1px solid #ccc;width:25px;height:25px;cursor:pointer;outline:1px solid #229BCA;margin-left 4px;"></span>'
					);
					$option_data[] = $design_option;
					if (isset($design['options']) && $design['options'] != '[]') {
						$design_options = is_string($design['options']) ? json_decode(str_replace('&quot;', '"', $design['options'])) : $design['options'];
						$html = '';
						for ($i = 0; $i < count($design_options); $i++) {
							if (empty($design_options[$i]['value'])) continue;
							if (is_string($design_options[$i]['value']) && !empty($design_options[$i]['value'])) {
								if (empty($design_options[$i]['name']) && $design_options[$i]['type'] == 'printing') {
									$design_options[$i]['name'] = $data['tshirtecommerce_printing_type'];
								}
								$html .= '<dt>'.$design_options[$i]['name'].': '.$design_options[$i]['value'].'</dt>';
							} elseif (count($design_options[$i]['value']) > 0) {
								$html .= '<dt>'.$design_options[$i]['name'].': </dt>';
								$html .=  '<dd>';
								foreach ($design_options[$i]['value'] as $name => $value) {
									if ($design_options[$i]['type'] == 'checkbox') {
										$html .=  $value. '; ';
									} else {
										if ($value != '0' && $value != 0) {
											$html .=  $name.'  -  '.$value. '; ';
										}
									}
								}
								$html .=  '</dd>';
							}
						}
						$design_option = array(
							'name'	=> 'Options',
							'value'	=> $html
						);
						$option_data[] = $design_option;
					}
					// teams
					if (isset($design['teams']) && isset($design['teams']['name'])) {
						$table = '<table class="table table-bordered">'
							. 		'<thead>'
							. 			'<tr>'
							. 				'<th>Name</th>'
							. 				'<th>Number</th>'
							. 				'<th>Sizes</th>'
							. 			'</tr>'
							. 		'</thead>'
							. 		'<tbody>';
						for ($i = 1; $i <= count($design['teams']['name']); $i++) {
							$size = explode('::', $design['teams']['size'][$i]);
							$table .=	'<tr>'
								.			'<td>'.$design['teams']['name'][$i].'</td>'
								.			'<td>'.$design['teams']['number'][$i].'</td>'
								.			'<td>'.$size[0].'</td>'
								.		'</tr>';
						}
						$table .= '</tbody></table>';
						$design_option = array(
							'name'	=> 'Team',
							'value'	=> $table
						);
						$option_data[] = $design_option;
					}
				} else {
					$design = '';					
				}
			
				$data['products'][] = array(

				'order_id' => (isset($product['design']['rowid']) ? $product['design']['rowid'] : 0),
				'parent_id' => (isset($product['design']['product_id']) ? $product['design']['product_id'] : 0),
				'design_product_id' => (isset($design_product_id) ? $design_product_id : 0),
			
=======
				/* Path: vqmod/xml/tshirtecommerce_product.xml */
				$tshirtecommerce = $this->model_tshirtecommerce_order->getCartOption($product['cart_id']);
				$tshirtecommerce = isset($tshirtecommerce['tshirtecommerce']) ? $tshirtecommerce['tshirtecommerce'] : array();
				if (count($tshirtecommerce) > 0) $tshirtecommerce['parent_id'] = $product['product_id'];

				// extend option_data here
				$option_data_new = $this->model_tshirtecommerce_order->extendOptions($tshirtecommerce, $option_data);
				$option_data = $option_data_new;
			
				$data['products'][] = array(
>>>>>>> 1c170fe64a36c3191167bac857d158e8ff3ecf46
					'cart_id'   => $product['cart_id'],
					'thumb'     => $image,
					'name'      => $product['name'],
					'model'     => $product['model'],
					'option'    => $option_data,
					'recurring' => $recurring,
					'quantity'  => $product['quantity'],
					'stock'     => $product['stock'] ? true : !(!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning')),
					'reward'    => ($product['reward'] ? sprintf($this->language->get('text_points'), $product['reward']) : ''),
					'price'     => $price,
					'total'     => $total,
					'href'      => $this->url->link('product/product', 'product_id=' . $product['product_id'])
				);
			}

			// Gift Voucher
			$data['vouchers'] = array();

			if (!empty($this->session->data['vouchers'])) {
				foreach ($this->session->data['vouchers'] as $key => $voucher) {
					$data['vouchers'][] = array(
						'key'         => $key,
						'description' => $voucher['description'],
						'amount'      => $this->currency->format($voucher['amount'], $this->session->data['currency']),
						'remove'      => $this->url->link('checkout/cart', 'remove=' . $key)
					);
				}
			}

			// Totals
<<<<<<< HEAD
			$this->load->model('extension/extension');
=======
			$this->load->model('setting/extension');
>>>>>>> 1c170fe64a36c3191167bac857d158e8ff3ecf46

			$totals = array();
			$taxes = $this->cart->getTaxes();
			$total = 0;
			
			// Because __call can not keep var references so we put them into an array. 			
			$total_data = array(
				'totals' => &$totals,
				'taxes'  => &$taxes,
				'total'  => &$total
			);
			
			// Display prices
			if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
				$sort_order = array();

<<<<<<< HEAD
				$results = $this->model_extension_extension->getExtensions('total');

				foreach ($results as $key => $value) {
					$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
=======
				$results = $this->model_setting_extension->getExtensions('total');

				foreach ($results as $key => $value) {
					$sort_order[$key] = $this->config->get('total_' . $value['code'] . '_sort_order');
>>>>>>> 1c170fe64a36c3191167bac857d158e8ff3ecf46
				}

				array_multisort($sort_order, SORT_ASC, $results);

				foreach ($results as $result) {
<<<<<<< HEAD
					if ($this->config->get($result['code'] . '_status')) {
=======
					if ($this->config->get('total_' . $result['code'] . '_status')) {
>>>>>>> 1c170fe64a36c3191167bac857d158e8ff3ecf46
						$this->load->model('extension/total/' . $result['code']);
						
						// We have to put the totals in an array so that they pass by reference.
						$this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
					}
				}

				$sort_order = array();

				foreach ($totals as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}

				array_multisort($sort_order, SORT_ASC, $totals);
			}

			$data['totals'] = array();

			foreach ($totals as $total) {
				$data['totals'][] = array(
					'title' => $total['title'],
					'text'  => $this->currency->format($total['value'], $this->session->data['currency'])
				);
			}

			$data['continue'] = $this->url->link('common/home');

			$data['checkout'] = $this->url->link('checkout/checkout', '', true);

<<<<<<< HEAD
			$this->load->model('extension/extension');
=======
			$this->load->model('setting/extension');
>>>>>>> 1c170fe64a36c3191167bac857d158e8ff3ecf46

			$data['modules'] = array();
			
			$files = glob(DIR_APPLICATION . '/controller/extension/total/*.php');

			if ($files) {
				foreach ($files as $file) {
					$result = $this->load->controller('extension/total/' . basename($file, '.php'));
					
					if ($result) {
						$data['modules'][] = $result;
					}
				}
			}

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('checkout/cart', $data));
		} else {
<<<<<<< HEAD
			$data['heading_title'] = $this->language->get('heading_title');

			$data['text_error'] = $this->language->get('text_empty');

			$data['button_continue'] = $this->language->get('button_continue');

=======
			$data['text_error'] = $this->language->get('text_empty');
			
>>>>>>> 1c170fe64a36c3191167bac857d158e8ff3ecf46
			$data['continue'] = $this->url->link('common/home');

			unset($this->session->data['success']);

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
	}

	public function add() {
		$this->load->language('checkout/cart');

		$json = array();

		if (isset($this->request->post['product_id'])) {
			$product_id = (int)$this->request->post['product_id'];
		} else {
			$product_id = 0;
		}

		$this->load->model('catalog/product');

		$product_info = $this->model_catalog_product->getProduct($product_id);

		if ($product_info) {
<<<<<<< HEAD
			if (isset($this->request->post['quantity']) && ((int)$this->request->post['quantity'] >= $product_info['minimum'])) {
				$quantity = (int)$this->request->post['quantity'];
			} else {
				$quantity = $product_info['minimum'] ? $product_info['minimum'] : 1;
			}


				if (isset($this->request->post['design']) && isset($this->request->post['design']['options'])) {
					$teoptions = $this->request->post['design']['options'];
					if (!defined('DS')) {
						define('DS', DIRECTORY_SEPARATOR);
					}
			        if (!defined('ROOT')) {
			        	define('ROOT', dirname(DIR_SYSTEM).DS.'tshirtecommerce');
			        }
			        include_once(ROOT.'/includes/functions.php');
			        $tdg = new \dg();
			        $tproduct_design_ids = $this->db->query("
						SELECT `design_product_id` 
						FROM `".DB_PREFIX."product` 
						WHERE `status` = 1 AND `product_id` = '".(int)$this->request->post['design']['product_id']."'
					");
					$teattributes = array();
					$tproduct_design_id = $tproduct_design_ids->row['design_product_id'];
					$tproduct_design_id_arr = explode(':', $tproduct_design_id);
					$tdesign_id = isset($tproduct_design_id_arr[1]) ? $tproduct_design_id_arr[1] : '';
					$tcache = $tdg->cache('admin');
					$tdesigns = $tcache->get($this->request->post['design']['rowid']);
					if (!empty($tdesign_id)) {
						$ttdesign = isset($tdesigns[$tdesign_id]) ? $tdesigns[$tdesign_id] : false;

						if ($ttdesign == false) {
							$tcache = $tdg->cache('design');
							$tdesigns = $tcache->get($this->request->post['design']['rowid']);
							$ttdesign = isset($tdesigns[$tdesign_id]) ? $tdesigns[$tdesign_id] : false;
						}
						if ($ttdesign !== false) {
							$teattributes['colors'] = $ttdesign['colors'];
							$teattributes['print'] = $ttdesign['print'];
							$teattributes['cliparts'] = $ttdesign['cliparts'];
							$teattributes['product_id'] = $ttdesign['product_id'];
							$tartStore = array();
							$evector = isset($ttdesign['vector']) ? $ttdesign['vector'] : '';
				            if (!empty($evector)) {
				                $json_evector = @json_decode($evector, true);
				                if (count($json_evector)) {
				                    foreach ($json_evector as $view => $items) {
				                        if (count($items)) {
				                            foreach ($items as $item) {
				                                if (isset($item['clipar_type']) && $item['clipar_type'] == 'store') {
				                                    $tartStore[] = $item['clipart_id'];
				                                }
				                            }
				                        }
				                    }
				                }
				            }
							$teattributes['artStore'] = $tartStore;

							if (!isset($ttdesign['attribute'])) $ttdesign['attribute'] = array();

							$tfile = dirname(DIR_SYSTEM).'/tshirtecommerce/data/products.json';
							$tstring = @file_get_contents($tfile);
							$eproducts = array();
							if ($tstring != false) {
								$tproducts = @json_decode($tstring, true);
								if (count($tproducts) > 0) {
									$eproducts = $tproducts['products'];
								}
							}
							$eattributes = array();
							foreach ($eproducts as $eproduct) {
								if ($eproduct['id'] == $this->request->post['design']['design_product_id']) {
									$eattributes = $eproduct['attributes'];
								}
							}
							$tattributes = array();
							foreach ($teoptions as $tkey => $tvalue) {
								switch ($tvalue['type']) {
									case 'checkbox':
										$ttemp = array();
										foreach ($tvalue['value'] as $ttkey => $ttvalue) {
											$ttemp[$ttkey] = $ttkey;
										}
										$tattributes[$tkey] = $ttemp;
										break;
									case 'selectbox':
									case 'radio':
											if (isset($eattributes['titles'][$tkey]) && count($eattributes['titles'][$tkey]) > 0) {
												foreach ($eattributes['titles'][$tkey] as $tttkey => $tttvalue) {
													if ($tttvalue == $tvalue['value']) {
														$tattributes[$tkey] = $tttkey;
													}
												}
											}
										break;
									case 'textlist':
										foreach ($tvalue['value'] as $ttkey => $ttvalue) {
											if (count($ttvalue) > 0) {
												if (isset($eattributes['titles'][$tkey]) && count($eattributes['titles'][$tkey]) > 0) {
													foreach ($eattributes['titles'][$tkey] as $tttkey => $tttvalue) {
														if ($tttvalue == $ttkey && $ttvalue > 0) {
															$tattributes[$tkey][$tttkey] = $ttvalue;
														}
													}
												}
											}
										}
										break;
									default:
										break;
								}
							}
							$teattributes['attribute'] = $tattributes;
						}
					} else {
						include dirname(DIR_SYSTEM).'/tshirtecommerce/opencart/includes/cart_blank.php';
					}
					$this->session->data[$this->request->post['design']['rowid']] = $teattributes;
				}
				if (isset($this->request->post['design']) && isset($this->request->post['design']['option_oc'])) {
					if (isset($this->request->post['design']['tattributes']) && isset($this->request->post['design']['rowid'])) {
						$this->session->data[$this->request->post['design']['rowid']] = $this->request->post['design']['tattributes'];
					}
					$this->load->model('catalog/product');
					$optoins_oc = $this->model_catalog_product->getProductOptions($product_id);
					$_options = array();
					$str_option_oc = str_replace('&quot;', '"', $this->request->post['design']['option_oc']);
					$temp_design_option_oc = array();
					$temp_option_oc = explode(';;', $str_option_oc);
					foreach ($temp_option_oc as $topc) {
						if (!empty($topc)) {
							$tstr = explode('::', $topc);
							if (count($tstr) > 1) {
								$is_tcheckbox = false;
								foreach ($optoins_oc as $op_oc) {
									if ($op_oc['product_option_id'] == $tstr[0] && $op_oc['type'] == 'checkbox') {
										$is_tcheckbox = true;
										break;
									}
								}
								if ($is_tcheckbox === false) {
									$temp_design_option_oc[$tstr[0]] = $tstr[1];
								} else {
									$ttmp = explode(',', $tstr[1]);
									if (count($ttmp) > 1) {
										foreach ($ttmp as $ttmp_value) {
											$temp_design_option_oc[$tstr[0]][] = $ttmp_value;
										}
									} else {
										$temp_design_option_oc[$tstr[0]][] = $tstr[1];
=======
			if (isset($this->request->post['quantity'])) {
				$quantity = (int)$this->request->post['quantity'];
			} else {
				$quantity = 1;
			}

			if (isset($this->request->post['option'])) {
				$option = array_filter($this->request->post['option']);
			} else {
				$option = array();
			}

			$product_options = $this->model_catalog_product->getProductOptions($this->request->post['product_id']);

				/* vqmod/xml/tshirtecommerce_product.xml */
				$this->load->model('tshirtecommerce/sproduct');
				if (isset($this->request->post['tshirtecommerce'])) {
					$tshirtecommerces = $this->request->post['tshirtecommerce'];

					if (isset($tshirtecommerces['colors'])) {
						$check_tshirtecommerce_colors = explode(';', $tshirtecommerces['colors']);
						if (count($check_tshirtecommerce_colors) > 0) {
							$tmp_colors = array();
							foreach ($check_tshirtecommerce_colors as $tcolor_hex) {
								if (!empty($tcolor_hex))
									$tmp_colors[] = $tcolor_hex;
							}
							$tshirtecommerces['colors'] = $tmp_colors;
						}
					} else {
						$tshirtecommerces['colors'] = false;
					}

					$tshirtecommerce = $this->model_tshirtecommerce_sproduct->getQtyAndPrice($tshirtecommerces, $this->request->post['product_id'], $quantity, true);
					$quantity = ($tshirtecommerce['quantity'] > 1) ? $tshirtecommerce['quantity'] : 1;
					if ($tshirtecommerce['type'] != 'cart') {
						$option['tshirtecommerce']['price_of_print'] = $tshirtecommerce['price_of_print'];
					}
					$option['tshirtecommerce']['options'] = $tshirtecommerces;
				} elseif (isset($this->request->post['design'])) {
					$tshirtecommerces = $this->request->post['design'];
					if (isset($tshirtecommerces) && count($tshirtecommerces) > 0 && isset($tshirtecommerces['refer']) && $tshirtecommerces['refer'] == 'designer') {
						if (isset($tshirtecommerces['color_hex'])) {
							$check_tshirtecommerce_colors = explode(';', $tshirtecommerces['color_hex']);
							if (count($check_tshirtecommerce_colors) > 0) {
								$tmp_colors = array();
								foreach ($check_tshirtecommerce_colors as $tcolor_hex) {
									if (!empty($tcolor_hex))
										$tmp_colors[] = $tcolor_hex;
								}
								$tshirtecommerces['colors'] = $tmp_colors;
							}
						} else {
							$tshirtecommerces['colors'] = false;
						}
						$tshirtecommerces['type'] = 'cart';
						$tshirtecommerce = $this->model_tshirtecommerce_sproduct->getQtyAndPrice($tshirtecommerces, $this->request->post['product_id'], $quantity, true);
						$quantity = ($tshirtecommerce['quantity'] > 1) ? $tshirtecommerce['quantity'] : 1;
						$option['tshirtecommerce']['price_of_print'] = $tshirtecommerce['price_of_print'];
						$option['tshirtecommerce']['options'] = $tshirtecommerces;

						// update opencart option
						if (isset($tshirtecommerces['option_oc']) && !empty($tshirtecommerces['option_oc'])) {
							$oc_option = array();
							$str_option_oc = str_replace('&quot;', '"', $tshirtecommerces['option_oc']);
							$array_option_oc = explode(';;', $str_option_oc);
							if (count($array_option_oc) > 0) {
								foreach ($array_option_oc as $row) {
									if (!empty($row) && $row != '') {
										$str_row_array = explode('::', $row);
										if (count($str_row_array) > 1) {
											$str_row_child = explode(',', $str_row_array[1]);
											if (count($str_row_child) > 0) {
												foreach ($str_row_child as $r) {
													if (!empty($r) && $r != '') $oc_option[$str_row_array[0]][] = $r;
												}
											}
										}
									}
								}
							}
							if (count($oc_option) > 0) {
								foreach ($oc_option as $key => $value) {
									if (isset($product_options) && count($product_options) > 0) {
										foreach ($product_options as $po) {
											if ($po['product_option_id'] == $key) {
												if ($po['type'] == 'text' || $po['type'] == 'textarea' || $po['type'] == 'file' || $po['type'] == 'date' || $po['type'] == 'datetime' || $po['type'] == 'time' || $po['type'] == 'select' || $po['type'] == 'radio') {
													$option[$key] = isset($value[0]) ? $value[0] : '';
												} else {
													$option[$key] = $value;
												}
												break;
											}
										}
									} else {
										$option[$key] = $value;
>>>>>>> 1c170fe64a36c3191167bac857d158e8ff3ecf46
									}
								}
							}
						}
					}
<<<<<<< HEAD
					$this->request->post['option'] = $temp_design_option_oc;
				}
			
			if (isset($this->request->post['option'])) {
				$option = array_filter($this->request->post['option']);
			} else {
				$option = array();
			}

			$product_options = $this->model_catalog_product->getProductOptions($this->request->post['product_id']);
=======
				}
			
>>>>>>> 1c170fe64a36c3191167bac857d158e8ff3ecf46

			foreach ($product_options as $product_option) {
				if ($product_option['required'] && empty($option[$product_option['product_option_id']])) {
					$json['error']['option'][$product_option['product_option_id']] = sprintf($this->language->get('error_required'), $product_option['name']);
				}
			}

			if (isset($this->request->post['recurring_id'])) {
				$recurring_id = $this->request->post['recurring_id'];
			} else {
				$recurring_id = 0;
			}

			$recurrings = $this->model_catalog_product->getProfiles($product_info['product_id']);

			if ($recurrings) {
				$recurring_ids = array();

				foreach ($recurrings as $recurring) {
					$recurring_ids[] = $recurring['recurring_id'];
				}

				if (!in_array($recurring_id, $recurring_ids)) {
					$json['error']['recurring'] = $this->language->get('error_recurring_required');
				}
			}

			if (!$json) {
<<<<<<< HEAD

				if (isset($this->request->post['design'])) {
					$design = $this->request->post['design'];
					$option['design'] = $design;
				} else {
					$str_design_product_id 	= '';
					$str_row_id = '';
					$str_color = '';
					$str_design = '';
					$this->load->model('tshirtecommerce/order');
					$tshirtecommerce_product = $this->model_tshirtecommerce_order->getProduct($this->request->post['product_id']);
					if (isset($tshirtecommerce_product['design_product_id'])) {
						$tshirtecommerce_split_arr = isset($tshirtecommerce_product['design_product_id']) ? explode(':', $tshirtecommerce_product['design_product_id']) : array();
						if (count($tshirtecommerce_split_arr) > 1) {
							$str_row_id = isset($tshirtecommerce_split_arr[0]) ? $tshirtecommerce_split_arr[0] : '';
							$str_design = isset($tshirtecommerce_split_arr[1]) ? $tshirtecommerce_split_arr[1] : '';
							$str_design_product_id = isset($tshirtecommerce_split_arr[2]) ? $tshirtecommerce_split_arr[2] : '';
							$str_color = isset($tshirtecommerce_split_arr[3]) ? $tshirtecommerce_split_arr[3] : '';
						} else {
							$str_design_product_id = $tshirtecommerce_product['design_product_id'];
						}
					}
					$tshirtecommerce_file = dirname(DIR_SYSTEM).'/tshirtecommerce/data/products.json';
					$tshirtecommerce_price = 0;
					if (file_exists($tshirtecommerce_file)) {
						$string = @file_get_contents($tshirtecommerce_file);
						if ($string != false) {
							$tshirtecommerce_products = json_decode($string, true);
							// Default product
							foreach ($tshirtecommerce_products['products'] as $p) {
								if ($p['id'] == $str_design_product_id) {
									$design = array();
									$design['rowid'] = (!empty($str_row_id)) ? $str_row_id : $str_design_product_id;
									if (!empty($str_row_id)) {
										foreach ($p['design']['color_hex'] as $idx => $color) {
											if ($str_color == $color) {
												$design['color_hex'] = $str_color;
												$design['color_title'] = $p['design']['color_title'][$idx];
												break;
											}
										}
									} else {
										$design['color_hex'] = isset($p['design']['color_hex'][0]) ? $p['design']['color_hex'][0] : '';
										$design['color_title'] = isset($p['design']['color_title'][0]) ? $p['design']['color_title'][0] : '';
									}

									$design['design_product_id'] = $p['id'];
									$design['images'] = '';
									$design['product_id'] = $tshirtecommerce_product['product_id'];
									$design['options'] = array();
									$design['options'][] = array('name' => 'Printing type', 'type' => 'printing', 'value' => $p['print_type']);

									if (!empty($str_row_id)) {
										$str_design_product_title_img = isset($product_info['design_product_title_img']) ? (explode('::', $product_info['design_product_title_img'])) : array();

										$oc_price_of_print = isset($str_design_product_title_img[2]) ? $str_design_product_title_img[2] : 0;
										
										$design['oc_price_of_print'] = $oc_price_of_print;
									} else {
										$design['oc_price_of_print'] = 0;
									}

									$option['design'] = $design;
								}
							}
						}
					}
				}
			
=======
>>>>>>> 1c170fe64a36c3191167bac857d158e8ff3ecf46
				$this->cart->add($this->request->post['product_id'], $quantity, $option, $recurring_id);

				$json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']), $product_info['name'], $this->url->link('checkout/cart'));

				// Unset all shipping and payment methods
				unset($this->session->data['shipping_method']);
				unset($this->session->data['shipping_methods']);
				unset($this->session->data['payment_method']);
				unset($this->session->data['payment_methods']);

				// Totals
<<<<<<< HEAD
				$this->load->model('extension/extension');
=======
				$this->load->model('setting/extension');
>>>>>>> 1c170fe64a36c3191167bac857d158e8ff3ecf46

				$totals = array();
				$taxes = $this->cart->getTaxes();
				$total = 0;
		
				// Because __call can not keep var references so we put them into an array. 			
				$total_data = array(
					'totals' => &$totals,
					'taxes'  => &$taxes,
					'total'  => &$total
				);

				// Display prices
				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$sort_order = array();

<<<<<<< HEAD
					$results = $this->model_extension_extension->getExtensions('total');

					foreach ($results as $key => $value) {
						$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
=======
					$results = $this->model_setting_extension->getExtensions('total');

					foreach ($results as $key => $value) {
						$sort_order[$key] = $this->config->get('total_' . $value['code'] . '_sort_order');
>>>>>>> 1c170fe64a36c3191167bac857d158e8ff3ecf46
					}

					array_multisort($sort_order, SORT_ASC, $results);

					foreach ($results as $result) {
<<<<<<< HEAD
						if ($this->config->get($result['code'] . '_status')) {
=======
						if ($this->config->get('total_' . $result['code'] . '_status')) {
>>>>>>> 1c170fe64a36c3191167bac857d158e8ff3ecf46
							$this->load->model('extension/total/' . $result['code']);

							// We have to put the totals in an array so that they pass by reference.
							$this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
						}
					}

					$sort_order = array();

					foreach ($totals as $key => $value) {
						$sort_order[$key] = $value['sort_order'];
					}

					array_multisort($sort_order, SORT_ASC, $totals);
				}

				$json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total, $this->session->data['currency']));
			} else {
				$json['redirect'] = str_replace('&amp;', '&', $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']));
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function edit() {
		$this->load->language('checkout/cart');

		$json = array();

		// Update
		if (!empty($this->request->post['quantity'])) {
			foreach ($this->request->post['quantity'] as $key => $value) {
<<<<<<< HEAD
				$this->cart->update($key, $value);
=======
				
				$this->load->model('tshirtecommerce/order');
				$tcheck = $this->model_tshirtecommerce_order->editCart($key);
				if ($tcheck['error'] == 0) {
					$this->cart->update($key, $value);
				} else {
					$this->session->data['error'] = $tcheck['msg'];
				}
			
>>>>>>> 1c170fe64a36c3191167bac857d158e8ff3ecf46
			}

			$this->session->data['success'] = $this->language->get('text_remove');

			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['reward']);

			$this->response->redirect($this->url->link('checkout/cart'));
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function remove() {
		$this->load->language('checkout/cart');

		$json = array();

		// Remove
		if (isset($this->request->post['key'])) {
			$this->cart->remove($this->request->post['key']);

			unset($this->session->data['vouchers'][$this->request->post['key']]);

			$json['success'] = $this->language->get('text_remove');

			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['reward']);

			// Totals
<<<<<<< HEAD
			$this->load->model('extension/extension');
=======
			$this->load->model('setting/extension');
>>>>>>> 1c170fe64a36c3191167bac857d158e8ff3ecf46

			$totals = array();
			$taxes = $this->cart->getTaxes();
			$total = 0;

			// Because __call can not keep var references so we put them into an array. 			
			$total_data = array(
				'totals' => &$totals,
				'taxes'  => &$taxes,
				'total'  => &$total
			);

			// Display prices
			if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
				$sort_order = array();

<<<<<<< HEAD
				$results = $this->model_extension_extension->getExtensions('total');

				foreach ($results as $key => $value) {
					$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
=======
				$results = $this->model_setting_extension->getExtensions('total');

				foreach ($results as $key => $value) {
					$sort_order[$key] = $this->config->get('total_' . $value['code'] . '_sort_order');
>>>>>>> 1c170fe64a36c3191167bac857d158e8ff3ecf46
				}

				array_multisort($sort_order, SORT_ASC, $results);

				foreach ($results as $result) {
<<<<<<< HEAD
					if ($this->config->get($result['code'] . '_status')) {
=======
					if ($this->config->get('total_' . $result['code'] . '_status')) {
>>>>>>> 1c170fe64a36c3191167bac857d158e8ff3ecf46
						$this->load->model('extension/total/' . $result['code']);

						// We have to put the totals in an array so that they pass by reference.
						$this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
					}
				}

				$sort_order = array();

				foreach ($totals as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}

				array_multisort($sort_order, SORT_ASC, $totals);
			}

			$json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total, $this->session->data['currency']));
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
