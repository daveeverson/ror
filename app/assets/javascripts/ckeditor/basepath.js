// use this next line and remove .erb from file name in app server
var CKEDITOR_BASEPATH = '/tribal_contacts/assets/ckeditor/';

// use this block in local dev environment and add .erb to end of filename eg: basepath.js.erb
// <%
//   base_path = ''
//   if ENV['PROJECT'] =~ /editor/i
//     base_path << "/#{Rails.root.basename.to_s}/"
//   end
//   base_path << Rails.application.config.assets.prefix
//   base_path << '/ckeditor/'
// %>
// var CKEDITOR_BASEPATH = '<%= base_path %>';