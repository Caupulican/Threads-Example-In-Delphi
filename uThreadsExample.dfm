object FrmThreads: TFrmThreads
  Left = 0
  Top = 0
  Caption = 'Thread Examples with ITask'
  ClientHeight = 83
  ClientWidth = 267
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 129
    Height = 25
    Caption = 'Single Thread'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 143
    Top = 8
    Width = 98
    Height = 25
    Caption = 'Thread Array'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 32
    Width = 129
    Height = 25
    Caption = 'Paralel For'
    TabOrder = 2
    OnClick = Button3Click
  end
end
