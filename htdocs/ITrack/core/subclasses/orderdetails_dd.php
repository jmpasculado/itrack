<?php
class orderdetails_dd
{
    static function load_dictionary()
    {
        $fields = array(
                        'id' => array('value'=>'',
                                              'data_type'=>'integer',
                                              'length'=>'11',
                                              'attribute'=>'primary&foreign key',
                                              'control_type'=>'none',
                                              'label'=>'Id',
                                              'extra'=>'',
                                              'in_listview'=>'yes',
                                              'char_set_method'=>'generate_num_set',
                                              'char_set_allow_space'=>'false',
                                              'extra_chars_allowed'=>'',
                                              'trim'=>'trim',
                                              'valid_set'=>array(),
                                              'date_elements'=>array('','',''),
                                              'book_list_generator'=>'',
                                              'list_type'=>'',
                                              'list_settings'=>array('')),
                        'Quantity' => array('value'=>'',
                                              'data_type'=>'integer',
                                              'length'=>'11',
                                              'attribute'=>'required',
                                              'control_type'=>'textbox',
                                              'label'=>'Quantity',
                                              'extra'=>'',
                                              'in_listview'=>'yes',
                                              'char_set_method'=>'generate_num_set',
                                              'char_set_allow_space'=>'false',
                                              'extra_chars_allowed'=>'',
                                              'trim'=>'trim',
                                              'valid_set'=>array(),
                                              'date_elements'=>array('','',''),
                                              'book_list_generator'=>'',
                                              'list_type'=>'',
                                              'list_settings'=>array('')),
                        'Inventory' => array('value'=>'',
                                              'data_type'=>'integer',
                                              'length'=>'11',
                                              'attribute'=>'primary&foreign key',
                                              'control_type'=>'drop-down list',
                                              'label'=>'Inventory',
                                              'extra'=>'',
                                              'in_listview'=>'yes',
                                              'char_set_method'=>'generate_num_set',
                                              'char_set_allow_space'=>'false',
                                              'extra_chars_allowed'=>'',
                                              'trim'=>'trim',
                                              'valid_set'=>array(),
                                              'date_elements'=>array('','',''),
                                              'book_list_generator'=>'',
                                              'list_type'=>'sql generated',
                                              'list_settings'=>array('query' => "SELECT inventory.id AS `Queried_id`, inventory.Name FROM itrack.inventory",
                                                                     'list_value' => 'Queried_id',
                                                                     'list_items' => array('Name'),
                                                                     'list_separators' => array()))
                       );
        return $fields;
    }

    static function load_relationships()
    {
        $relations = array('1'=>array('type'=>'1-M',
                                      'table'=>'purchaseorder',
                                      'link_parent'=>'id',
                                      'link_child'=>'id',
                                      'link_subtext'=>array(''),
                                      'where_clause'=>''),
                           '2'=>array('type'=>'1-1',
                                      'table'=>'inventory',
                                      'link_parent'=>'id',
                                      'link_child'=>'Inventory',
                                      'link_subtext'=>array('Name'),
                                      'where_clause'=>''));

        return $relations;
    }

    static function load_subclass_info()
    {
        $subclasses = array('html_file'=>'orderdetails_html.php',
                            'html_class'=>'orderdetails_html',
                            'data_file'=>'orderdetails.php',
                            'data_class'=>'orderdetails');
        return $subclasses;
    }

}