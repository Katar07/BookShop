table 50358 "Cart Line"
{
    Caption = 'Cart Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Cart No."; Code[20])
        {
            Caption = 'Cart No.';
            TableRelation = Cart."No.";
        }
        field(2; "Line No."; Integer)
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
                Rec.Validate(Quantity, 1);
                Rec.Validate(UnitPrice, Item."Unit Price");
            end;
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                If Rec.Quantity <= 0 then
                    Error('Quantity must be 1 or more!');
                Rec.Validate(Amount);
            end;
        }
        field(5; UnitPrice; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = AccountData;
            Editable = false;

            trigger OnValidate()
            begin
                Rec.Validate(Amount);
            end;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = AccountData;
            Editable = false;

            trigger OnValidate()
            begin
                Amount := Quantity * UnitPrice;
            end;
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(8; "Flow Description"; Text[100])
        {
            Caption = 'Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
        }
    }
    keys
    {
        key(PK; "Cart No.", "Line No.")
        {
            Clustered = true;
        }

        key(Sift; "Cart No.")
        {
            SumIndexFields = Amount;

        }

    }
}
