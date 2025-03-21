object HumRemovalModule: THumRemovalModule
  OnCreate = VSTModuleCreate
  OnDestroy = VSTModuleDestroy
  Version = '1.0'
  EffectName = 'Hum Removal'
  ProductName = 'DAV Effect Examples'
  VendorName = 'Delphi ASIO & VST Project'
  PlugCategory = vpcEffect
  SampleRate = 44100.000000000000000000
  CurrentProgramName = 'Default'
  IORatio = 1.000000000000000000
  UniqueID = 'HumR'
  ShellPlugins = <>
  Programs = <
    item
      DisplayName = 'Default'
      VSTModule = Owner
    end>
  ParameterProperties = <
    item
      CurveFactor = 1.000000000000000000
      Category = 'Highpass'
      DisplayName = 'Highpass Active'
      Flags = [ppfParameterIsSwitch, ppfParameterUsesIntegerMinMax, ppfParameterUsesIntStep, ppfParameterSupportsDisplayIndex, ppfParameterSupportsDisplayCategory]
      LargeStepFloat = 1.000000000000000000
      LargeStepInteger = 1
      Max = 1.000000000000000000
      MaxInteger = 1
      ReportVST2Properties = True
      ShortLabel = 'HP Act.'
      SmallStepFloat = 1.000000000000000000
      StepFloat = 1.000000000000000000
      VSTModule = Owner
      OnParameterChange = ParameterHighpassActiveChange
      OnCustomParameterDisplay = ParameterHighpassActiveDisplay
    end
    item
      CurveFactor = 1.000000000000000000
      Category = 'Highpass'
      DisplayName = 'Highpass Type'
      Flags = [ppfParameterUsesIntegerMinMax, ppfParameterUsesIntStep, ppfParameterSupportsDisplayIndex, ppfParameterSupportsDisplayCategory]
      LargeStepFloat = 1.000000000000000000
      LargeStepInteger = 1
      Max = 2.000000000000000000
      MaxInteger = 2
      ReportVST2Properties = True
      ShortLabel = 'HP Type'
      SmallStepFloat = 1.000000000000000000
      StepFloat = 1.000000000000000000
      VSTModule = Owner
      OnParameterChange = ParameterHighpassTypeChange
      OnCustomParameterDisplay = ParameterHighpassTypeDisplay
    end
    item
      Curve = ctLogarithmic
      CurveFactor = 100.000000000000000000
      Category = 'Highpass'
      DisplayName = 'Highpass Frequency'
      Flags = [ppfParameterUsesFloatStep, ppfParameterSupportsDisplayIndex, ppfParameterSupportsDisplayCategory]
      LargeStepFloat = 2.000000000000000000
      Max = 200.000000000000000000
      MaxInteger = 200
      Min = 2.000000000000000000
      MinInteger = 2
      ReportVST2Properties = True
      ShortLabel = 'HP Freq'
      SmallStepFloat = 0.500000000000000000
      StepFloat = 1.000000000000000000
      Units = 'Hz'
      VSTModule = Owner
      OnParameterChange = ParameterHighpassFrequencyChange
    end
    item
      Curve = ctLogarithmic
      CurveFactor = 16.000000000000000000
      Category = 'Highpass'
      DisplayName = 'Highpass Order'
      Flags = [ppfParameterUsesIntegerMinMax, ppfParameterUsesIntStep, ppfParameterSupportsDisplayIndex, ppfParameterSupportsDisplayCategory]
      LargeStepFloat = 2.000000000000000000
      Max = 16.000000000000000000
      MaxInteger = 16
      Min = 1.000000000000000000
      MinInteger = 1
      ReportVST2Properties = True
      ShortLabel = 'HP Ord.'
      SmallStepFloat = 0.500000000000000000
      StepFloat = 1.000000000000000000
      VSTModule = Owner
      OnParameterChange = ParameterHighpassOrderChange
      OnCustomParameterDisplay = ParameterHighpassOrderDisplay
    end
    item
      Curve = ctLogarithmic
      CurveFactor = 3.000000000000000000
      Category = 'Notch Filter'
      DisplayName = 'Fundamental Frequency'
      Flags = [ppfParameterUsesFloatStep, ppfParameterSupportsDisplayIndex, ppfParameterSupportsDisplayCategory]
      LargeStepFloat = 2.000000000000000000
      Max = 120.000000000000000000
      MaxInteger = 120
      Min = 40.000000000000000000
      MinInteger = 40
      ReportVST2Properties = True
      ShortLabel = 'Fund.'
      SmallStepFloat = 0.500000000000000000
      StepFloat = 1.000000000000000000
      Units = 'Hz'
      VSTModule = Owner
      OnParameterChange = ParameterFundamentalFrequencyChange
    end
    item
      Curve = ctLogarithmic
      CurveFactor = 10.000000000000000000
      Category = 'Notch Filter'
      DisplayName = 'Bandwidth'
      Flags = [ppfParameterUsesFloatStep, ppfParameterSupportsDisplayIndex, ppfParameterSupportsDisplayCategory]
      LargeStepFloat = 2.000000000000000000
      Max = 0.300000011920929000
      MaxInteger = 1
      Min = 0.029999999329447750
      ReportVST2Properties = True
      ShortLabel = 'BW'
      SmallStepFloat = 0.500000000000000000
      StepFloat = 1.000000000000000000
      Units = 'Oct'
      VSTModule = Owner
      OnParameterChange = ParameterBandwidthChange
    end
    item
      CurveFactor = 1.000000000000000000
      DisplayName = 'Attenuation'
      LargeStepFloat = 2.000000000000000000
      Max = 96.000000000000000000
      MaxInteger = 96
      ShortLabel = 'Attn.'
      SmallStepFloat = 0.500000000000000000
      StepFloat = 1.000000000000000000
      Units = 'dB'
      UseDefaultString2ParameterHandler = True
      VSTModule = Owner
      OnParameterChange = ParameterAttenuationChange
    end
    item
      CurveFactor = 1.000000000000000000
      DisplayName = 'Capture Hum Profile'
      Flags = [ppfParameterIsSwitch, ppfParameterUsesIntegerMinMax, ppfParameterUsesIntStep, ppfParameterSupportsDisplayIndex]
      LargeStepFloat = 1.000000000000000000
      LargeStepInteger = 1
      Max = 1.000000000000000000
      MaxInteger = 1
      ReportVST2Properties = True
      ShortLabel = 'Profile'
      SmallStepFloat = 1.000000000000000000
      StepFloat = 1.000000000000000000
      VSTModule = Owner
      OnParameterChange = ParameterCaptureHumProfileChange
    end>
  ParameterCategories = <
    item
      DisplayName = 'Highpass'
      VSTModule = Owner
    end
    item
      DisplayName = 'Notch Filter'
      VSTModule = Owner
    end>
  OnOpen = VSTModuleOpen
  OnClose = VSTModuleClose
  OnProcess = VSTModuleProcess
  OnProcess32Replacing = VSTModuleProcess
  OnSampleRateChange = VSTModuleSampleRateChange
  Height = 150
  Width = 215
end
