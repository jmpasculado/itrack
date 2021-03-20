<?php
require_once 'inventory_dd.php';
class inventory extends data_abstraction
{
    var $fields = array();
    var $tables='inventory';

    function inventory()
    {
        $this->fields = inventory_dd::load_dictionary();
        $this->relations = inventory_dd::load_relationships();
        $this->subclasses = inventory_dd::load_subclass_info();
    }
	

    function add($param, $log_query=TRUE)
    {
        $this->escape_arguments($param);
        extract($param);
        $this->set_query_type('INSERT');
        $this->set_fields('id, Name, Brand, Description, Quantity, PerShelf, Unit, Price');
        $this->set_values("'$id', '$Name', '$Brand', '$Description', '$Quantity', '$PerShelf', '$Unit', '$Price'");
        $this->make_query(TRUE,$log_query);
    }

    function edit($param, $log_query=TRUE)
    {
        $this->escape_arguments($param);
        extract($param);
        $this->set_query_type('UPDATE');
        $this->set_update("Name = '$Name', Brand = '$Brand', Description = '$Description', Quantity = '$Quantity', PerShelf = '$PerShelf', Unit = '$Unit', Price = '$Price'");
        $this->set_where("id = '$id'");
        $this->make_query(TRUE,$log_query);
    }

    function del($param, $log_query=TRUE)
    {
        $this->escape_arguments($param);
        extract($param);
        $this->set_query_type('DELETE');
        $this->set_where("id = '$id'");
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
        $this->set_where("id = '$id'");
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
        $this->set_where("id = '$id' AND (id != '$id')");
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
            $Name = str_replace('"',"''", $Name);
            $Brand = str_replace('"',"''", $Brand);
            $Description = str_replace('"',"''", $Description);
            $Quantity = str_replace('"',"''", $Quantity);
            $PerShelf = str_replace('"',"''", $PerShelf);
            $Unit = str_replace('"',"''", $Unit);
            $Price = str_replace('"',"''", $Price);

            $csv_contents .= '"' . $id . '","' . $Name . '","' . $Brand . '","' . $Description . '","' . $Quantity . '","' . $PerShelf . '","' . $Unit . '","' . $Price . '"' . "\r\n";
        }

        return $csv_contents;
    }
}
