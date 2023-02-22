table 50352 "Item Book Category"
{
    Caption = 'Book Category';
    DataClassification = CustomerContent;
    LookupPageId = "Item Book Category List";

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            AutoIncrement = true;

        }
        field(2; "Category Name"; Text[100])
        {
            Caption = 'Category Name';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Category Name") { }
    }
}
