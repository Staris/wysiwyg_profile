<?php
// $Id$

/**
 * Return an array of the modules to be enabled when this profile is installed.
 *
 * @return
 *   An array of modules to enable.
 */
function wysiwyg_profile_profile_modules() {
  return array(
	  // Default install
    'color', 'comment', 'help', 'menu', 'taxonomy', 'dblog', 'path', 
    // Standard modules
    'admin', 'ctools', 'diff', 'drupalforfirebug', 'drupalforfirebug_preprocess', 'htmlpurifier', 'image_resize_filter', 'pathauto', 'strongarm', 'token', 'views', 'views_ui', 
    // CCK
    'content', 'fieldgroup', 'filefield', 'imagefield', 'nodereference', 'number', 'optionwidgets', 'text', 'userreference',
    // Image tools
    'imageapi', 'imageapi_gd', 'imageapi_imagemagick', 'imagecache', 'imagecache_ui',
    // Chaos Tools
    'ctools', 'panels', 
    // Wysiwyg
    'wysiwyg', 'imce', 'imce_wysiwyg', 
    // Features tools
    'features', 'wysiwyg_configuration', 
  );
}

/**
 * Return a description of the profile for the initial installation screen.
 *
 * @return
 *   An array with keys 'name' and 'description' describing this profile,
 *   and optional 'language' to override the language selection for
 *   language-specific profiles.
 */
function wysiwyg_profile_profile_details() {
  return array(
    'name' => 'Wysiwyg Editor',
    'description' => 'Select this profile to enable some basic Drupal functionality, Wysiwyg Editor, and the default theme.'
  );
}

/**
 * Return a list of tasks that this profile supports.
 *
 * @return
 *   A keyed array of tasks the profile will perform during
 *   the final stage. The keys of the array will be used internally,
 *   while the values will be displayed to the user in the installer
 *   task list.
 */
function wysiwyg_profile_profile_task_list() {
}

/**
 * Perform any final installation tasks for this profile.
 *
 * The installer goes through the profile-select -> locale-select
 * -> requirements -> database -> profile-install-batch
 * -> locale-initial-batch -> configure -> locale-remaining-batch
 * -> finished -> done tasks, in this order, if you don't implement
 * this function in your profile.
 *
 * If this function is implemented, you can have any number of
 * custom tasks to perform after 'configure', implementing a state
 * machine here to walk the user through those tasks. First time,
 * this function gets called with $task set to 'profile', and you
 * can advance to further tasks by setting $task to your tasks'
 * identifiers, used as array keys in the hook_profile_task_list()
 * above. You must avoid the reserved tasks listed in
 * install_reserved_tasks(). If you implement your custom tasks,
 * this function will get called in every HTTP request (for form
 * processing, printing your information screens and so on) until
 * you advance to the 'profile-finished' task, with which you
 * hand control back to the installer. Each custom page you
 * return needs to provide a way to continue, such as a form
 * submission or a link. You should also set custom page titles.
 *
 * You should define the list of custom tasks you implement by
 * returning an array of them in hook_profile_task_list(), as these
 * show up in the list of tasks on the installer user interface.
 *
 * Remember that the user will be able to reload the pages multiple
 * times, so you might want to use variable_set() and variable_get()
 * to remember your data and control further processing, if $task
 * is insufficient. Should a profile want to display a form here,
 * it can; the form should set '#redirect' to FALSE, and rely on
 * an action in the submit handler, such as variable_set(), to
 * detect submission and proceed to further tasks. See the configuration
 * form handling code in install_tasks() for an example.
 *
 * Important: Any temporary variables should be removed using
 * variable_del() before advancing to the 'profile-finished' phase.
 *
 * @param $task
 *   The current $task of the install system. When hook_profile_tasks()
 *   is first called, this is 'profile'.
 * @param $url
 *   Complete URL to be used for a link or form action on a custom page,
 *   if providing any, to allow the user to proceed with the installation.
 *
 * @return
 *   An optional HTML string to display to the user. Only used if you
 *   modify the $task, otherwise discarded.
 */
function wysiwyg_profile_profile_tasks(&$task, $url) {

  // Insert default user-defined node types into the database. For a complete
  // list of available node type attributes, refer to the node type API
  // documentation at: http://api.drupal.org/api/HEAD/function/hook_node_info.
  $types = array(
    array(
      'type' => 'page',
      'name' => st('Page'),
      'module' => 'node',
      'description' => st("A <em>page</em>, similar in form to a <em>story</em>, is a simple method for creating and displaying information that rarely changes, such as an \"About us\" section of a website. By default, a <em>page</em> entry does not allow visitor comments and is not featured on the site's initial home page."),
      'custom' => TRUE,
      'modified' => TRUE,
      'locked' => FALSE,
      'help' => '',
      'min_word_count' => '',
    ),
    array(
      'type' => 'story',
      'name' => st('Story'),
      'module' => 'node',
      'description' => st("A <em>story</em>, similar in form to a <em>page</em>, is ideal for creating and displaying content that informs or engages website visitors. Press releases, site announcements, and informal blog-like entries may all be created with a <em>story</em> entry. By default, a <em>story</em> entry is automatically featured on the site's initial home page, and provides the ability to post comments."),
      'custom' => TRUE,
      'modified' => TRUE,
      'locked' => FALSE,
      'help' => '',
      'min_word_count' => '',
    ),
  );

  foreach ($types as $type) {
    $type = (object) _node_type_set_defaults($type);
    node_type_save($type);
  }

  // Default page to not be promoted and have comments disabled.
  variable_set('node_options_page', array('status'));

  // Don't display date and author information for page nodes by default.
  $theme_settings = variable_get('theme_settings', array());
  $theme_settings['toggle_node_info_page'] = FALSE;
  variable_set('theme_settings', $theme_settings);
	
	// Make an 'administrator' role
  db_query("INSERT INTO {role} (rid, name) VALUES (3, 'administrator')");
	
	// Insert new role's permissions
	db_query("INSERT INTO {permission} (rid, perm, tid) VALUES (3, 'use admin toolbar, administer blocks, access comments, administer comments, post comments, post comments without approval, administer menu, administer content types, administer nodes, create page content, create story content, delete any page content, delete any story content, delete own page content, delete own story content, edit any page content, edit any story content, edit own page content, edit own story content, view pane admin links, administer url aliases, create url aliases, access administration pages, administer site configuration, select different theme, administer taxonomy, access user profiles, administer permissions, administer users', 0)");
		
	//Imce Role Profile update for the role administrator
	$imcerolesettings =array(
    3 => array(
      'weight' => '-10',
      'pid' => '1',
    ),
    2 => array(
      'weight' => 11,
      'pid' => '2',
    ),
    1 => array(
      'weight' => 12,
      'pid' => '0',
    ),
  );
  variable_set('imce_roles_profiles', $imcerolesettings);
	
  // Update the menu router information.
  menu_rebuild();
}

/**
 * Implementation of hook_form_alter().
 *
 * Allows the profile to alter the site-configuration form. This is
 * called through custom invocation, so $form_state is not populated.
 */
function wysiwyg_profile_form_alter(&$form, $form_state, $form_id) {
  if ($form_id == 'install_configure') {
    // Set default for site name field.
    $form['site_information']['site_name']['#default_value'] = $_SERVER['SERVER_NAME'];
  }
}
