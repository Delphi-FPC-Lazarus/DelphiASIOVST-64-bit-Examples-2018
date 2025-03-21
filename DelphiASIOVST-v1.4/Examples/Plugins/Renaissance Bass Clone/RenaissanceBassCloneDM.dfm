object ResurrectionBassCloneModule: TResurrectionBassCloneModule
  OldCreateOrder = False
  OnCreate = VSTModuleCreate
  OnDestroy = VSTModuleDestroy
  Version = '1.0'
  EffectName = 'RenaissanceBass Clone'
  ProductName = 'DAV Effect Examples'
  VendorName = 'Delphi ASIO & VST Project'
  PlugCategory = vpcEffect
  SampleRate = 44100.000000000000000000
  CurrentProgramName = 'RenaissanceBass Full Reset'
  IORatio = 1.000000000000000000
  UniqueID = 'DMBC'
  ShellPlugins = <>
  Programs = <
    item
      DisplayName = 'RenaissanceBass Full Reset'
      VSTModule = Owner
    end
    item
      DisplayName = 'Ultralow Extender'
      VSTModule = Owner
    end
    item
      DisplayName = 'Light'
      VSTModule = Owner
    end
    item
      DisplayName = 'Medium'
      VSTModule = Owner
    end
    item
      DisplayName = 'Aggressive'
      VSTModule = Owner
    end>
  ParameterProperties = <
    item
      CurveFactor = 1.000000000000000000
      Category = 'Crossover'
      DisplayName = 'Frequency'
      Flags = [ppfParameterUsesFloatStep, ppfParameterSupportsDisplayIndex, ppfParameterSupportsDisplayCategory]
      LargeStepFloat = 2.000000000000000000
      Max = 256.000000000000000000
      MaxInteger = 256
      Min = 32.000000000000000000
      MinInteger = 32
      ReportVST2Properties = True
      ShortLabel = 'Freq.'
      SmallStepFloat = 0.500000000000000000
      StepFloat = 1.000000000000000000
      Units = 'Hz'
      VSTModule = Owner
      OnParameterChange = ParameterFrequencyChange
    end
    item
      CurveFactor = 1.000000000000000000
      Category = 'Dynamics'
      DisplayName = 'Add Original Bass'
      Flags = [ppfParameterIsSwitch, ppfParameterUsesIntegerMinMax, ppfParameterUsesIntStep, ppfParameterSupportsDisplayIndex, ppfParameterSupportsDisplayCategory]
      LargeStepFloat = 2.000000000000000000
      Max = 1.000000000000000000
      MaxInteger = 1
      ReportVST2Properties = True
      ShortLabel = 'AddBass'
      SmallStepFloat = 0.500000000000000000
      StepFloat = 1.000000000000000000
      VSTModule = Owner
      OnParameterChange = ParameterAddOriginalBassChange
      OnCustomParameterDisplay = ParameterAddOriginalBassDisplay
    end
    item
      CurveFactor = 1.000000000000000000
      Category = 'Mix'
      DisplayName = 'Intensity'
      Flags = [ppfParameterUsesFloatStep, ppfParameterSupportsDisplayIndex, ppfParameterSupportsDisplayCategory]
      LargeStepFloat = 2.000000000000000000
      Max = 24.000000000000000000
      MaxInteger = 24
      Min = -24.000000000000000000
      MinInteger = -24
      ReportVST2Properties = True
      ShortLabel = 'Intensi'
      SmallStepFloat = 0.500000000000000000
      StepFloat = 1.000000000000000000
      Units = 'dB'
      VSTModule = Owner
      OnParameterChange = ParameterIntensityChange
    end
    item
      Curve = ctLogarithmic
      CurveFactor = 101.000000000000000000
      Category = 'Mix'
      DisplayName = 'Gain'
      Flags = [ppfParameterUsesFloatStep, ppfParameterSupportsDisplayIndex, ppfParameterSupportsDisplayCategory]
      LargeStepFloat = 2.000000000000000000
      Max = 3.990524530410767000
      MaxInteger = 4
      ReportVST2Properties = True
      ShortLabel = 'OrgBass'
      SmallStepFloat = 0.500000000000000000
      StepFloat = 1.000000000000000000
      Units = 'dB'
      VSTModule = Owner
      OnParameterChange = ParameterGainChange
      OnCustomParameterDisplay = ParameterdBDisplay
    end>
  ParameterCategories = <
    item
      DisplayName = 'Crossover'
      VSTModule = Owner
    end
    item
      DisplayName = 'Dynamics'
      VSTModule = Owner
    end
    item
      DisplayName = 'Harmonics'
      VSTModule = Owner
    end
    item
      DisplayName = 'Mix'
      VSTModule = Owner
    end
    item
      DisplayName = 'Control'
      VSTModule = Owner
    end>
  OnOpen = VSTModuleOpen
  OnClose = VSTModuleClose
  OnProcess = VSTModuleProcess
  OnProcess32Replacing = VSTModuleProcess
  OnProcess64Replacing = VSTModuleProcessDoubleReplacing
  OnSampleRateChange = VSTModuleSampleRateChange
  Left = 290
  Top = 82
  Height = 150
  Width = 215
end
