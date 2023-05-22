#!/bin/bash

DATABASE="contract_book.db"

# Function to add a contract
add_contract() {
    echo "Enter contract details:"
    echo -n "Name: "
    read name
    echo -n "Company: "
    read company
    echo -n "Start date (YYYY-MM-DD): "
    read start_date
    echo -n "End date (YYYY-MM-DD): "
    read end_date

    sqlite3 $DATABASE "INSERT INTO contracts (name, company, start_date, end_date) VALUES ('$name', '$company', '$start_date', '$end_date');"
    echo "Contract added successfully."
}

# Function to list all contracts
list_contracts() {
    sqlite3 -header -column $DATABASE "SELECT * FROM contracts;"
}

# Function to delete a contract
delete_contract() {
    echo -n "Enter the ID of the contract you want to delete: "
    read contract_id

    sqlite3 $DATABASE "DELETE FROM contracts WHERE id = $contract_id;"
    echo "Contract deleted successfully."
}

# Function to update a contract
update_contract() {
    echo -n "Enter the ID of the contract you want to update: "
    read contract_id

    echo "Enter new contract details:"
    echo -n "Name: "
    read name
    echo -n "Company: "
    read company
    echo -n "Start date (YYYY-MM-DD): "
    read start_date
    echo -n "End date (YYYY-MM-DD): "
    read end_date

    sqlite3 $DATABASE "UPDATE contracts SET name = '$name', company = '$company', start_date = '$start_date', end_date = '$end_date' WHERE id = $contract_id;"
    echo "Contract updated successfully."
}

# Function to display the menu
display_menu() {
    echo ""
    echo "Contract Book Application"
    echo "-------------------------"
    echo "1. Add Contract"
    echo "2. List Contracts"
    echo "3. Delete Contract"
    echo "4. Update Contract"
    echo "5. Exit"
    echo ""
    echo -n "Enter your choice: "
}

# Main script logic
create_database

while true; do
    display_menu
    read choice

    case $choice in
        1)
            add_contract
            ;;
        2)
            list_contracts
            ;;
        3)
            delete_contract
            ;;
        4)
            update_contract
            ;;
        5)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done
