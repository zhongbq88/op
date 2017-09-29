<?php
/**
 * @author 		tshirtecommerce - https://tshirtecommerce.com
 * @date 		January 17, 2017
 * 
 * API 			4.1.3
 * 
 * @copyright  	Copyright (C) 2015 https://tshirtecommerce.com. All rights reserved.
 * @license    	GNU General Public License version 2 or later; see LICENSE
 *
 */

class ControllerCatalogTshirtecommerce extends Controller {
	private $error = array();
	
    public function index()
    {
		$this->load->language('module/tshirtecommerce');
		$this->document->setTitle($this->language->get('heading_title'));
		
		// get language
		$data['product_build'] = $this->language->get('product_build');
		$data['heading_title'] = $this->language->get('heading_title');
		$data['breadcrumbs']   = array();
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token='.$this->session->data['token'], true)
		);
		
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/tshirtecommerce/index', 'token='.$this->session->data['token'], true)
		);
	
		$dir_admins = explode('/', DIR_APPLICATION);
		$dir_admin = empty($dir_admins[count($dir_admins) - 1]) ? $dir_admins[count($dir_admins) - 2] : $dir_admins[count($dir_admins) - 1];
		if (isset($_SERVER["HTTPS"]) && $_SERVER["HTTPS"] == "on" || (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https')) {
			if (strpos(HTTPS_SERVER, '/'.$dir_admin.'/') !== false) {
				$url = str_replace('/'.$dir_admin.'/', '', HTTPS_SERVER).'/tshirtecommerce/admin/index.php';
			} else {
				$url = str_replace($dir_admin, '', HTTPS_SERVER).'/tshirtecommerce/admin/index.php';
			}
		} else {
			if (strpos(HTTP_SERVER, '/'.$dir_admin.'/') !== false) {
				$url = str_replace('/'.$dir_admin.'/', '', HTTP_SERVER).'/tshirtecommerce/admin/index.php';
			} else {
				$url = str_replace($dir_admin, '', HTTP_SERVER).'/tshirtecommerce/admin/index.php';
			}		
		}

		$data['url'] = $url;
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
	
		$this->load->model('user/user');
		$user = $this->model_user_user->getUser($this->session->data['user_id']);
		
		$is_admin = array(
			'login' => true,
			'email' => $user['email'],
			'id' => $this->session->data['user_id'],
		);

		$_SESSION['is_admin'] = $is_admin;
		$this->session->data['is_admin'] = $is_admin;

		// write session to file
		$sess_json = json_encode($is_admin);
		$sess_file = dirname(DIR_SYSTEM).'/tshirtecommerce/admin/tmp/session_'.session_id();
		$this->write_to_file($sess_json, $sess_file);
		$data['url'] .= '?session_id='.session_id();
		
		$this->response->setOutput($this->load->view('catalog/tshirtecommerce', $data));
    }
	
	protected function write_to_file($text,$new_filename)
	{
		$fp = @fopen($new_filename, 'w');
		@fwrite($fp, $text);
		@fclose($fp);
	}
	
	// check update
	public function update()
	{
		$this->load->language('module/tshirtecommerce');
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');

		$code = (null !== $this->config->get('tshirtecommerce_code')) ? $this->config->get('tshirtecommerce_code') : '';
		$oc_version = str_replace('.', '', VERSION);
		
		// auto update
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			if (empty($code) || str_replace(' ', '', $code) == '') {
				$data['error_warning'] = 'Please enter your Purchase codes before update or download new version. Click <a style="font-weight:bold" href="'.$this->url->link('module/tshirtecommerce', 'token='.$this->session->data['token'], true).'">here</a> to setting';

				$data['permission_warning'] = 'Before you update new version, please <span style="font-weight:bold;"> backup the files and the data of your current installation!</span>';
			} else {
				$ts_version = str_replace('.','',$this->request->post['update']);
				$file = 'http://updates.tshirtecommerce.com/api.php?code='.$code.'&version='.$ts_version.'&platform=opencart&opencart='.$oc_version;
				$content = $this->openURL($file);
				if ($content !== false) {
					$path = dirname(DIR_SYSTEM).'/opencart_'.$ts_version;
					if (@file_put_contents($path, $content)) {
						$zip = new ZipArchive();
						if ($zip->open($path)) {
							$zip->extractTo(dirname(DIR_SYSTEM));
							$zip->close();
							$data['success'] = '<strong>Update complete:</strong> Your version has been successfully updated.';
						} else {
							$data['error_warning'] = '<strong>Update failed:</strong> Can not open file downloaded on your server. Please try to download and upload to server by FTP account';
						}						
					}
				} else {
					$data['error_warning'] = $this->language->get('updata_file_found');
				}
			}
		} else {
			$data['permission_warning'] = 'Before you update new version, please <span style="font-weight:bold;">always backup the files and the data of your current installation!</span>';
		}
		

		if (isset($this->error['warning'])) $data['error_warning'] = $this->error['warning'];
		if (isset($this->error['code'])) $data['error_warning'] = $this->error['code'];
		
		// load language
		$data['updata_head'] = $this->language->get('updata_head');
		$data['updata_version'] = $this->language->get('updata_version');
		$data['updata_fontd'] = $this->language->get('updata_fontd');
		
		// check version
		$file = dirname(DIR_SYSTEM).'/tshirtecommerce/version.json';
		$version = '';
		if (file_exists($file)) {
			$str = @file_get_contents($file);
			if ($str !== false) {
				$content = json_decode($str);
				$version = $content->version;
			}
		}
		$data['version'] = $version;
		
		// load update content
		$file = 'http://updates.tshirtecommerce.com/opencart/updates.json';
		$content = $this->openURL($file);
		if ($content !== false) {
			$versions = json_decode($content);
			if (count($versions)) $data['versions'] = $versions;
		}
		
		$data['code'] = $code;
		$data['oc_version'] = $oc_version;
		$data['link'] = $this->url->link('catalog/tshirtecommerce/update', 'token='.$this->session->data['token'], true);
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $data['link']
		);
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		
		// Verify code
		$data['tshirtecommerce_verify'] = array();
		if (!empty($code)) {
			$json_str = $this->openURL('http://updates.tshirtecommerce.com/verify_purchase.php?code='.$code.'&platform=opencart');
			if ($json_str !== false) $data['tshirtecommerce_verify'] = json_decode($json_str, true);
		}

		if (empty($code) || str_replace(' ', '', $code) == '' || count($data['tshirtecommerce_verify']) == 0 || $data['tshirtecommerce_verify']['error'] == 1) {
			$data['error_warning'] = 'Please enter your Purchase codes before update or download new version. Click <a style="font-weight:bold;" href="'.$this->url->link('module/tshirtecommerce', 'token='.$this->session->data['token'], true).'">here</a> to setting';
		}
		
		$this->response->setOutput($this->load->view('catalog/tshirtecommerce_update', $data));		
	}

	public function help()
	{
		$this->load->language('module/tshirtecommerce');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('setting/setting');

		// load language
		$data['updata_head'] = 'Helps';
		$data['link'] = $this->url->link('catalog/tshirtecommerce/help', 'token='.$this->session->data['token'], true);
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $data['link']
		);
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/tshirtecommerce_help', $data));		
	}
	
	private function openURL($url)
	{		
		if (ini_get('allow_url_fopen')) {
			$data = @file_get_contents($url);
			if ($data == false) return false;
		} else {		
			$ch = @curl_init();
			curl_setopt($ch, CURLOPT_URL, $url);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
			$data = @curl_exec($ch);
			@curl_close($ch);
		}

		return $data;
	}
	
	public function ajax()
	{
		$dir_admins = explode('/', DIR_APPLICATION);
		$dir_admin = empty($dir_admins[count($dir_admins) - 1]) ? $dir_admins[count($dir_admins) - 2] : $dir_admins[count($dir_admins) - 1];
		if (isset($_SERVER["HTTPS"]) && $_SERVER["HTTPS"] == "on" || (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https')) {
			if (strpos(HTTPS_SERVER, '/'.$dir_admin.'/') !== false) {
				$url = str_replace('/'.$dir_admin.'/', '', HTTPS_SERVER).'/tshirtecommerce/admin.php?key=123';
			} else {
				$url = str_replace($dir_admin, '', HTTPS_SERVER).'/tshirtecommerce/admin.php?key=123';
			}
		} else {
			if (strpos(HTTP_SERVER, '/'.$dir_admin.'/') !== false) {
				$url = str_replace('/'.$dir_admin.'/', '', HTTP_SERVER).'/tshirtecommerce/admin.php?key=123';
			} else {
				$url = str_replace($dir_admin, '', HTTP_SERVER).'/tshirtecommerce/admin.php?key=123';
			}
		}

		echo $this->openURL($url);		
		exit;
	}
	
	
	protected function validateForm()
	{
		if (!$this->user->hasPermission('modify', 'catalog/tshirtecommerce')) $this->error['warning'] = $this->language->get('error_permission');
		if ($_FILES["import_design"]["name"] == '') $this->error['code'] = $this->language->get('error_name');
		
		if (!$this->error) {
			return true;
		} else {
			return $this->error;
		}	
	}
	
	protected function validate()
	{
		if (!$this->user->hasPermission('modify', 'catalog/tshirtecommerce')) $this->error['warning'] = $this->language->get('error_permission');
		if (!$this->request->post['designer_code']) $this->error['code'] = $this->language->get('error_code');

		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
	
	protected function validateDelete()
	{
		if (!$this->user->hasPermission('modify', 'catalog/tshirtecommerce')) $this->error['warning'] = $this->language->get('error_permission');

		if (!$this->error) {
			return true; 
		} else {
			return false;
		}
	}

	protected function validateRepair()
	{
		if (!$this->user->hasPermission('modify', 'catalog/tshirtecommerce')) $this->error['warning'] = $this->language->get('error_permission');

		if (!$this->error) {
			return true; 
		} else {
			return false;
		}
	}
}
?>