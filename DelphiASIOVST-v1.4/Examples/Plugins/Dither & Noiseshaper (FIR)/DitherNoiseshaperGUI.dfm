object FmDitherNoiseshaper: TFmDitherNoiseshaper
  Left = 264
  Top = 81
  BorderStyle = bsNone
  Caption = 'Dither & Noiseshaper Example'
  ClientHeight = 85
  ClientWidth = 251
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LbNoiseshaperType: TLabel
    Left = 8
    Top = 62
    Width = 90
    Height = 13
    Caption = 'Noiseshaper Type:'
  end
  object LbFinalBitDepth: TLabel
    Left = 4
    Top = 7
    Width = 73
    Height = 13
    Caption = 'Final Bit Depth:'
  end
  object LbBit: TLabel
    Left = 156
    Top = 7
    Width = 12
    Height = 13
    Caption = 'Bit'
  end
  object LbDitherType: TLabel
    Left = 8
    Top = 36
    Width = 60
    Height = 13
    Caption = 'Dither Type:'
  end
  object LbDitherAmp: TLabel
    Left = 182
    Top = 36
    Width = 25
    Height = 13
    Caption = 'Amp:'
  end
  object DialAmplitude: TGuiDial
    Left = 210
    Top = 29
    Width = 24
    Height = 24
    CircleColor = clBtnShadow
    CurveMapping = -1.000000000000000000
    DefaultPosition = 1.000000000000000000
    DialImageIndex = -1
    LineColor = clBtnHighlight
    LineWidth = 2
    Max = 4.000000000000000000
    OnChange = DialAmplitudeChange
    PointerAngles.Start = 225
    PointerAngles.Range = 270
    PointerAngles.Resolution = 270.000000000000000000
    Position = 1.000000000000000000
    ScrollRange_Pixel = 400.000000000000000000
    StitchKind = skHorizontal
    WheelStep = 1.000000000000000000
  end
  object CbNoiseshaperType: TComboBox
    Left = 104
    Top = 59
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 2
    TabOrder = 0
    Text = 'Simple Highpass (2nd Order)'
    OnChange = CbNoiseshaperTypeChange
    Items.Strings = (
      'None'
      'Simple Error Feedback (1st Order)'
      'Simple Highpass (2nd Order)'
      'mod. E-weighting (2nd Order)'
      'mod. E-weighting (3rd Order)'
      'mod. E-weighting (9th Order)'
      'improved E-weighting (5th Order)'
      'improved E-weighting (9th Order)'
      'F-weighting (3rd Order)'
      'F-weighting (9th Order)'
      'Sony "Super Bit Mapping"'
      'Reduced "Super Bit Mapping"'
      'Sharp 14 kHz (7th Order)'
      'Sharp 15kHz (8th Order)'
      'Sharp 16kHz (9th Order)'
      'Experimental')
  end
  object SeBitDepth: TSpinEdit
    Left = 100
    Top = 4
    Width = 49
    Height = 22
    MaxValue = 32
    MinValue = 1
    TabOrder = 1
    Value = 16
    OnChange = SeBitDepthChange
  end
  object CbLimit: TCheckBox
    Left = 187
    Top = 6
    Width = 42
    Height = 17
    Caption = 'Limit'
    TabOrder = 2
    OnClick = CbLimitClick
  end
  object CbDitherType: TComboBox
    Left = 74
    Top = 32
    Width = 99
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 4
    TabOrder = 3
    Text = 'Fast Gauss'
    OnChange = CbDitherTypeChange
    Items.Strings = (
      'none'
      'Rectangle'
      'Triangular'
      'Gauss'
      'Fast Gauss')
  end
end
