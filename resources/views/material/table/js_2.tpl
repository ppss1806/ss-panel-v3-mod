table_1 = $('#table_1').DataTable({
  ajax: '{$table_config['ajax_url']}',
  processing: true,
  serverSide: true,
  order: [[ 0, 'desc' ]],
  columns: [
        {foreach $table_config['total_column'] as $key => $value}
          { "data": "{$key}" },
        {/foreach}
    ]
})

{foreach $table_config['total_column'] as $key => $value}
  modify_table_visible('checkbox_{$key}', '{$key}');
{/foreach}
