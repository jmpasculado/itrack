<?php
require_once 'customer_dd.php';
class customer_html extends html
{
    function customer_html()
    {
        $this->fields = customer_dd::load_dictionary();
        $this->relations = customer_dd::load_relationships();
        $this->subclasses = customer_dd::load_subclass_info();
    }
}
