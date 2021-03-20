<?php
require_once 'customer_dd.php';
class customer extends data_abstraction
{
    var $fields = array();
    var $tables='customer';

    function customer()
    {
        $this->fields = customer_dd::load_dictionary();
        $this->relations = customer_dd::load_relationships();
        $this->subclasses = customer_dd::load_subclass_info();
    }

    function add($param, $log_query=TRUE)
    {
        $this->escape_arguments($param);
        extract($param);
        $this->set_query_type('INSERT');
        $this->set_fields('id, FirstName, LastName, Email, Company, Mobile, Telephone, Fax, Address');
        $this->set_values("'$id', '$FirstName', '$LastName', '$Email', '$Company', '$Mobile', '$Telephone', '$Fax', '$Address'");
        $this->make_query(TRUE,$log_query);
    }

    function edit($param, $log_query=TRUE)
    {
        $this->escape_arguments($param);
        extract($param);
        $this->set_query_type('UPDATE');
        $this->set_update("FirstName = '$FirstName', LastName = '$LastName', Email = '$Email', Company = '$Company', Mobile = '$Mobile', Telephone = '$Telephone', Fax = '$Fax', Address = '$Address'");
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
            $FirstName = str_replace('"',"''", $FirstName);
            $LastName = str_replace('"',"''", $LastName);
            $Email = str_replace('"',"''", $Email);
            $Company = str_replace('"',"''", $Company);
            $Mobile = str_replace('"',"''", $Mobile);
            $Telephone = str_replace('"',"''", $Telephone);
            $Fax = str_replace('"',"''", $Fax);
            $Address = str_replace('"',"''", $Address);

            $csv_contents .= '"' . $id . '","' . $FirstName . '","' . $LastName . '","' . $Email . '","' . $Company . '","' . $Mobile . '","' . $Telephone . '","' . $Fax . '","' . $Address . '"' . "\r\n";
        }

        return $csv_contents;
    }
}
