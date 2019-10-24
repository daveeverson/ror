CKEDITOR.editorConfig = function( config ) {
	config.disableNativeSpellChecker = false;

	config.toolbar=
	[
		{ name: 'basicstyles', items :['Bold', 'Italic', 'Underline', 'Strike', '-', 'Link', 'Unlink']}
	];

	config.removePlugins = 'elementspath'; config.resize_enabled = false;
};