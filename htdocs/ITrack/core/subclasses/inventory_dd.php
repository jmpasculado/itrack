<?php
class inventory_dd
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
                        'Name' => array('value'=>'',
                                              'data_type'=>'varchar',
                                              'length'=>'255',
                                              'attribute'=>'required',
                                              'control_type'=>'textbox',
                                              'label'=>'Name',
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
                                              'list_settings'=>array('')),
                        'Brand' => array('value'=>'',
                                              'data_type'=>'varchar',
                                              'length'=>'255',
                                              'attribute'=>'required',
                                              'control_type'=>'textbox',
                                              'label'=>'Brand',
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
                                              'list_settings'=>array('')),
                        'Description' => array('value'=>'',
                                              'data_type'=>'text',
                                              'length'=>'255',
                                              'attribute'=>'required',
                                              'control_type'=>'textarea',
                                              'label'=>'Description',
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
                        'PerShelf' => array('value'=>'',
                                              'data_type'=>'integer',
                                              'length'=>'11',
                                              'attribute'=>'required',
                                              'control_type'=>'textbox',
                                              'label'=>'PerShelf',
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
                        'Unit' => array('value'=>'',
                                              'data_type'=>'varchar',
                                              'length'=>'255',
                                              'attribute'=>'required',
                                              'control_type'=>'textbox',
                                              'label'=>'Unit',
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
                                              'list_settings'=>array('')),
                        'Price' => array('value'=>'',
                                              'data_type'=>'integer',
                                              'length'=>'11',
                                              'attribute'=>'required',
                                              'control_type'=>'textbox',
                                              'label'=>'Price',
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
                                              'list_settings'=>array(''))
                       );
        return $fields;
    }

    static function load_relationships()
    {
        $relations = array();

        return $relations;
    }

    static function load_subclass_info()
    {
        $subclasses = array('html_file'=>'inventory_html.php',
                            'html_class'=>'inventory_html',
                            'data_file'=>'inventory.php',
                            'data_class'=>'inventory');
        return $subclasses;
    }

}