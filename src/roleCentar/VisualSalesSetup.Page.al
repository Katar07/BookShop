page 50377 "Visual Sales Setup"
{
    ApplicationArea = All;
    Caption = 'Visual Sales Setup';
    PageType = Card;
    SourceTable = "VisualTableSetup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Media1; Rec.Media1)
                {
                    ToolTip = 'Specifies the value of the Blob1 field.';
                }
                field(Media2; Rec.Media2)
                {
                    ToolTip = 'Specifies the value of the Blob1 field.';
                }
                field(Media3; Rec.Media3)
                {
                    ToolTip = 'Specifies the value of the Blob1 field.';
                }
                field(Media4; Rec.Media4)
                {
                    ToolTip = 'Specifies the value of the Blob1 field.';
                }
                field(Media5; Rec.Media5)
                {
                    ToolTip = 'Specifies the value of the Blob1 field.';
                }
                field(Media6; Rec.Media6)
                {
                    ToolTip = 'Specifies the value of the Blob1 field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ImportMedia1)
            {
                ApplicationArea = All;
                Caption = 'ImportMedia1';
                Image = Import;
                ToolTip = 'Executes the ImportMedia action.';

                trigger OnAction()
                var
                    FromFileName: Text;
                    InStreamPic: InStream;
                begin
                    if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FromFileName, InStreamPic) then begin
                        Rec.Media1.ImportStream(InStreamPic, FromFileName);

                        Rec.Modify(true);
                    end;
                end;
            }
            action(ImportMedia2)
            {
                ApplicationArea = All;
                Caption = 'ImportMedia2';
                Image = Import;
                ToolTip = 'Executes the ImportMedia action.';

                trigger OnAction()
                var
                    FromFileName: Text;
                    InStreamPic: InStream;
                begin
                    if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FromFileName, InStreamPic) then begin
                        Rec.Media2.ImportStream(InStreamPic, FromFileName);
                        Rec.Modify(true);
                    end;
                end;
            }
            action(ImportMedia3)
            {
                ApplicationArea = All;
                Caption = 'ImportMedia3';
                Image = Import;
                ToolTip = 'Executes the ImportMedia action.';

                trigger OnAction()
                var
                    FromFileName: Text;
                    InStreamPic: InStream;
                begin
                    if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FromFileName, InStreamPic) then begin
                        Rec.Media3.ImportStream(InStreamPic, FromFileName);
                        Rec.Modify(true);
                    end;
                end;
            }
            action(ImportMedia4)
            {
                ApplicationArea = All;
                Caption = 'ImportMedia4';
                Image = Import;
                ToolTip = 'Executes the ImportMedia action.';

                trigger OnAction()
                var
                    FromFileName: Text;
                    InStreamPic: InStream;
                begin
                    if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FromFileName, InStreamPic) then begin
                        Rec.Media4.ImportStream(InStreamPic, FromFileName);
                        Rec.Modify(true);
                    end;
                end;
            }
            action(ImportMedia5)
            {
                ApplicationArea = All;
                Caption = 'ImportMedia5';
                Image = Import;
                ToolTip = 'Executes the ImportMedia action.';

                trigger OnAction()
                var
                    FromFileName: Text;
                    InStreamPic: InStream;
                begin
                    if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FromFileName, InStreamPic) then begin
                        Rec.Media5.ImportStream(InStreamPic, FromFileName);
                        Rec.Modify(true);
                    end;
                end;
            }
            action(ImportMedia6)
            {
                ApplicationArea = All;
                Caption = 'ImportMedia6';
                Image = Import;
                ToolTip = 'Executes the ImportMedia action.';

                trigger OnAction()
                var
                    FromFileName: Text;
                    InStreamPic: InStream;
                begin
                    if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FromFileName, InStreamPic) then begin
                        Rec.Media6.ImportStream(InStreamPic, FromFileName);
                        Rec.Modify(true);
                    end;
                end;
            }
        }
    }
}
