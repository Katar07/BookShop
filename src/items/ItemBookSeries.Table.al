table 50353 "Item Book Series"
{
    Caption = 'Book Series';
    DataClassification = CustomerContent;
    LookupPageId = "Item Book Series List";

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            AutoIncrement = true;

        }
        field(2; "Book Series Name"; Text[100])
        {
            Caption = 'Book Series Name';
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
        fieldgroup(DropDown; "Book Series Name") { }
    }



}
