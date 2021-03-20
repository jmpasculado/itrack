<?php
require_once 'salesorder_dd.php';
class salesorder extends data_abstraction
{
    var $fields = array();
    var $tables='salesorder';

    function salesorder()
    {
        $this->fields = salesorder_dd::load_dictionary();
        $this->relations = salesorder_dd::load_relationships();
        $this->subclasses = salesorder_dd::load_subclass_info();
    }

    function add($param, $log_query=TRUE)
    {
        $this->escape_arguments($param);
        extract($param);
        $this->set_query_type('INSERT');
        $this->set_fields('id, Date, Employee, Status, PurchaseOrder');
        $this->set_values("'$id', '$Date', '$Employee', '$Status', '$PurchaseOrder'");
        $this->make_query(TRUE,$log_query);
    }

    function edit($param, $log_query=TRUE)
    {
        $this->escape_arguments($param);
        extract($param);
        $this->set_query_type('UPDATE');
        $this->set_update("Date = '$Date', Employee = '$Employee', Status = '$Status', PurchaseOrder = '$PurchaseOrder'");
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
            $Date = str_replace('"',"''", $Date);
            $Employee = str_replace('"',"''", $Employee);
            $Status = str_replace('"',"''", $Status);
            $PurchaseOrder = str_replace('"',"''", $PurchaseOrder);

            $csv_contents .= '"' . $id . '","' . $Date . '","' . $Employee . '","' . $Status . '","' . $PurchaseOrder . '"' . "\r\n";
        }

        return $csv_contents;
    }
}
