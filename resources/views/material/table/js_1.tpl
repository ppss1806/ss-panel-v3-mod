function modify_table_visible(id, key) {
	if(document.getElementById(id).checked)
	{
		table_1.columns( '.' + key ).visible( true );
	}
	else
	{
		table_1.columns( '.' + key ).visible( false );
	}
}
