table 50364 "Return Cart Line"
{
    Caption = 'Return Cart Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Return Cart No."; Code[20])
        {
            Caption = 'Cart No.';
            TableRelation = "Return Cart"."No.";
        }
        field(2; "Return Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No." where("Item Category Code" = const('BOOKS'));

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                Item.Get(Rec."Item No.");
                Rec.Validate(Description, Item.Description);
            end;
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';
            trigger OnValidate()
            begin
                Rec.Validate(Amount);
            end;
        }
        field(5; ReturnUnitPrice; Decimal)
        {
            Caption = 'Return Unit Price';
            DataClassification = AccountData;
            Editable = false;

        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = AccountData;
            Editable = false;

            trigger OnValidate()
            begin
                Amount := Quantity * ReturnUnitPrice;
            end;
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(8; "Flow Description"; Text[100])
        {
            Caption = 'Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
        }
        field(9; "Price For Overdue"; Decimal)
        {
            Caption = 'Price For Day Overdue';
            Editable = false;
        }
        field(10; DueDate; Date)
        {
            Caption = 'Due Date';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Return Cart No.", "Return Line No.")
        {
            Clustered = true;
        }

        key(Sift; "Return Cart No.")
        {
            SumIndexFields = Amount;

        }

    }

}
