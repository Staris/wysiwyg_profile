api = 2
core = "6.x"

; Standard projects
projects[admin][subdir] = "standard"
projects[admin][version] = "2"

projects[cck][subdir] = "standard"
projects[cck][version] = "2"

projects[ctools][subdir] = "standard"
projects[ctools][version] = "1"

projects[drupalforfirebug][subdir] = "standard"
projects[drupalforfirebug][version] = "1"

projects[diff][subdir] = "standard"
projects[diff][version] = "2"

projects[features][subdir] = "standard"
projects[features][version] = "1"

projects[filefield][subdir] = "standard"
projects[filefield][version] = "3"

projects[imageapi][subdir] = "standard"
projects[imageapi][version] = "1"

projects[imagecache][subdir] = "standard"
projects[imagecache][version] = "2"

projects[imagefield][subdir] = "standard"
projects[imagefield][version] = "3"

projects[panels][subdir] = "standard"
projects[panels][version] = "3"

projects[pathauto][subdir] = "standard"
projects[pathauto][version] = "1"

projects[strongarm][subdir] = "standard"
projects[strongarm][version] = "2"

projects[token][subdir] = "standard"
projects[token][version] = "1"

projects[views][subdir] = "standard"
projects[views][version] = "2"

; Input Filter
projects[htmlpurifier][subdir] = "standard"
projects[htmlpurifier][version] = "2"

projects[image_resize_filter][subdir] = "standard"
projects[image_resize_filter][version] = "1"

; Wysiwyg
projects[imce][subdir] = "standard"
projects[imce][version] = "1"

projects[imce_wysiwyg][subdir] = "standard"
projects[imce_wysiwyg][version] = "1"

projects[wysiwyg][subdir] = "standard"
projects[wysiwyg][version] = "2"

;Libraries
libraries[htmlpurifier_library][download][type] = "get"
libraries[htmlpurifier_library][destination] = "modules/standard/htmlpurifier"
libraries[htmlpurifier_library][download][url] = "http://htmlpurifier.org/releases/htmlpurifier-4.3.0-lite.zip"
libraries[htmlpurifier_library][directory_name] = "library"

libraries[ckeditor][download][type] = "get"
libraries[ckeditor][destination] = "libraries"
libraries[ckeditor][download][url] = "http://download.cksource.com/CKEditor/CKEditor/CKEditor%203.4.1/ckeditor_3.4.1.zip"
libraries[ckeditor][directory_name] = "ckeditor"

;Features
libraries[wysiwyg_configuration][download][type] = "git"
libraries[wysiwyg_configuration][destination] = "modules/features"
libraries[wysiwyg_configuration][download][url] = "git://github.com/Staris/wysiwyg_configuration_6.git"
libraries[wysiwyg_configuration][directory_name] = "wysiwyg_configuration"