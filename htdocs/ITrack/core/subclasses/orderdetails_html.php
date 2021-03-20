<?php
require_once 'orderdetails_dd.php';
class orderdetails_html extends html
{
    function orderdetails_html()
    {
        $this->fields = orderdetails_dd::load_dictionary();
        $this->relations = orderdetails_dd::load_relationships();
        $this->subclasses = orderdetails_dd::load_subclass_info();
    }
}
