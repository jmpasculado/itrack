<?php
class purchaseorder_dd
{
    static function load_dictionary()
    {
        $fields = array(
                        'id' => array('value'=>'',
                                              'data_type'=>'integer',
                                              'length'=>'11',
                                              'attribute'=>'primary key',
                                              'control_type'=>'none',
                                              'label'=>'Id',
                                              'extra'=>'',
                                              'in_listview'=>'no',
                                              'char_set_method'=>'generate_num_set',
                                              'char_set_allow_space'=>'false',
                                              'extra_chars_allowed'=>'',
                                              'trim'=>'trim',
                                              'valid_set'=>array(),
                                              'date_elements'=>array('','',''),
                                              'book_list_generator'=>'',
                                              'list_type'=>'',
                                              'list_settings'=>array('')),
                        'Customer' => array('value'=>'',
                                              'data_type'=>'integer',
                                              'length'=>'11',
                                              'attribute'=>'foreign key',
                                              'control_type'=>'drop-down list',
                                              'label'=>'Customer',
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
                                              'list_settings'=>array('query' => "SELECT customer.id AS `Queried_id`, customer.Company FROM itrack.customer",
                                                                     'list_value' => 'Queried_id',
                                                                     'list_items' => array('Company'),
                                                                     'list_separators' => array())),
                        'DateOfDelivery' => array('value'=>'',
                                              'data_type'=>'date',
                                              'length'=>'0',
                                              'attribute'=>'required',
                                              'control_type'=>'date controls',
                                              'label'=>'DateOfDelivery',
                                              'extra'=>'',
                                              'in_listview'=>'yes',
                                              'char_set_method'=>'generate_alphanum_set',
                                              'char_set_allow_space'=>'true',
                                              'extra_chars_allowed'=>'\' / - ( ) + = . , ! ? # % & * ; : _ "',
                                              'trim'=>'trim',
                                              'valid_set'=>array(),
                                              'date_elements'=>array('DateOfDelivery_year','DateOfDelivery_month','DateOfDelivery_day'),
                                              'book_list_generator'=>'',
                                              'list_type'=>'',
                                              'list_settings'=>array('')),
                        'Date' => array('value'=>'',
                                              'data_type'=>'date',
                                              'length'=>'0',
                                              'attribute'=>'required',
                                              'control_type'=>'date controls',
                                              'label'=>'Date',
                                              'extra'=>'',
                                              'in_listview'=>'yes',
                                              'char_set_method'=>'generate_alphanum_set',
                                              'char_set_allow_space'=>'true',
                                              'extra_chars_allowed'=>'\' / - ( ) + = . , ! ? # % & * ; : _ "',
                                              'trim'=>'trim',
                                              'valid_set'=>array(),
                                              'date_elements'=>array('year','month','day'),
                                              'book_list_generator'=>'',
                                              'list_type'=>'',
                                              'list_settings'=>array('')),
                        'Status' => array('value'=>'',
                                              'data_type'=>'varchar',
                                              'length'=>'255',
                                              'attribute'=>'required',
                                              'control_type'=>'textbox',
                                              'label'=>'Status',
                                              'extra'=>'',
                                              'in_listview'=>'yes',
                                              'char_set_method'=>'generate_alphanum_set',
                                              'char_set_allow_space'=>'true',
                                              'extra_chars_allowed'=>'\' / - ( ) + = . , ! ? # % & * ; : _ "',
                                              'trim'=>'trim',
                                              'valid_set'=>array(),
                                              'date_elements'=>array('','',''),
                                              'book_list_generator'=>'',
                                              'list_type'=>'',
                                              'list_settings'=>array(''))
                       );
        return $fields;
    }

    static function load_relationships()
    {
        $relations = array('1'=>array('type'=>'1-1',
                                      'table'=>'customer',
                                      'link_parent'=>'id',
                                      'link_child'=>'Customer',
                                      'link_subtext'=>array('Company'),
                                      'where_clause'=>''));

        return $relations;
    }

    static function load_subclass_info()
    {
        $subclasses = array('html_file'=>'purchaseorder_html.php',
                            'html_class'=>'purchaseorder_html',
                            'data_file'=>'purchaseorder.php',
                            'data_class'=>'purchaseorder');
        return $subclasses;
    }

}