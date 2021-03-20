<?php
require_once 'orderdetails_dd.php';
class orderdetails extends data_abstraction
{
    var $fields = array();
    var $tables='orderdetails';

    function orderdetails()
    {
        $this->fields = orderdetails_dd::load_dictionary();
        $this->relations = orderdetails_dd::load_relationships();
        $this->subclasses = orderdetails_dd::load_subclass_info();
    }

    function add($param, $log_query=TRUE)
    {
		
        $this->escape_arguments($param);
        extract($param);
        $this->set_query_type('INSERT');
        $this->set_fields('id, Quantity, Inventory');
        $this->set_values("'$id', '$Quantity', '$Inventory'");
        $this->make_query(TRUE,$log_query);
		require_once 'inventory_dd1.php';
    }

    function edit($param, $log_query=TRUE)
    {
        $this->escape_arguments($param);
        extract($param);
        $this->set_query_type('UPDATE');
        $this->set_update("Quantity = '$Quantity', Inventory = '$Inventory'");
        $this->set_where("id = '$id' AND Inventory = '$orig_Inventory'");
        $this->make_query(TRUE,$log_query);
    }

    function del($param, $log_query=TRUE)
    {
        $this->escape_arguments($param);
        extract($param);
        $this->set_query_type('DELETE');
        $this->set_where("id = '$id' AND Inventory = '$Inventory'");
        $this->make_query(TRUE,$log_query);
    }

    function select($log_query=TRUE)
    {
        $this->set_query_type('SELECT');
        $result = $this->make_query(TRUE,$log_query);
        return $result;
    }

    function check_uniqueness($param)
    {
        $this->escape_arguments($param);
        extract($param);
        $this->set_query_type('SELECT');
        $this->set_where("id = '$id' AND Inventory = '$Inventory'");
        $this->make_query(TRUE,$log_query);
        if($this->num_rows > 0) $this->is_unique = FALSE;
        else $this->is_unique = TRUE;

        return $this->is_unique;
    }

    function check_uniqueness_for_editing($param)
    {
        $this->escape_arguments($param);
        extract($param);
        $this->set_query_type('SELECT');
        $this->set_where("id = '$id' AND Inventory = '$Inventory' AND (id != '$id' OR Inventory != '$orig_Inventory')");
        $this->make_query(TRUE,$log_query);
        if($this->num_rows > 0) $this->is_unique = FALSE;
        else $this->is_unique = TRUE;

        return $this->is_unique;
    }

    function export_to_csv()
    {
        $result = $this->select();
        while($data = $result->fetch_assoc())
        {
            extract($data);

            $id = str_replace('"',"''", $id);
            $Quantity = str_replace('"',"''", $Quantity);
            $Inventory = str_replace('"',"''", $Inventory);

            $csv_contents .= '"' . $id . '","' . $Quantity . '","' . $Inventory . '"' . "\r\n";
        }

        return $csv_contents;
    }
}
