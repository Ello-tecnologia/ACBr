{******************************************************************************}
{ Projeto: Componente ACBreSocial                                              }
{  Biblioteca multiplataforma de componentes Delphi para envio dos eventos do  }
{ eSocial - http://www.esocial.gov.br/                                         }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       Andr� Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 27/10/2015: Jean Carlo Cantu, Tiago Ravache
|*  - Doa��o do componente para o Projeto ACBr
|* 29/02/2016: Guilherme Costa
|*  - Alterado os atributos que n�o estavam de acordo com o leiaute/xsd
******************************************************************************}
{$I ACBr.inc}

unit pcesS5011;

interface

uses
  SysUtils, Classes,
  pcnConversao, pcnLeitor, ACBrUtil,
  pcesCommon, pcesConversaoeSocial;

type
  TS5011 = class;

  TInfoCS = class;
  TInfoCPSeg = class;
  TInfoContrib = class;
  TideEstabCollection = class;
  TideEstabCollectionItem = class;
  TideLotacaoCollection = class;
  TideLotacaoCollectionItem = class;
  TInfoCRContribCollection = class;
  TInfoCRContribCollectionItem = class;
  TInfoTercSuspCollection = class;
  TInfoTercSuspCollectionItem = class;
  TbasesRemunCollection = class;
  TbasesremunCollectionItem = class;
  TinfoSubstPatrOpPortCollection = class;
  TinfoSubstPatrOpPortCollectionItem = class;
  TbasesAquisCollection = class;
  TbasesAquisCollectionItem = class;
  TbasesComercCollection = class;
  TbasesComercCollectionItem = class;
  TinfoCREstabCollection = class;
  TinfoCREstabCollectionItem = class;

  TEvtCS = class;

  TS5011 = class(TInterfacedObject, IEventoeSocial)
  private
    FTipoEvento: TTipoEvento;
    FEvtCS: TEvtCS;

    function GetXml : string;
    procedure SetXml(const Value: string);
    function GetTipoEvento : TTipoEvento;
    procedure SetEvtCS(const Value: TEvtCS);

  public
    constructor Create;
    destructor Destroy; override;

    function GetEvento : TObject;

  published
    property Xml: String read GetXml write SetXml;
    property TipoEvento: TTipoEvento read GetTipoEvento;
    property EvtCS: TEvtCS read FEvtCS write setEvtCS;

  end;

  TInfoCPSeg = class(TPersistent)
  private
    FvrDescCP: Double;
    FvrCpSeg: Double;
  public
    property vrDescCP: Double read FvrDescCP write FvrDescCP;
    property vrCpSeg: Double read FvrCpSeg write FvrCpSeg;
  end;

  TInfoAtConc = class(TPersistent)
  private
    FfatorMes: Double;
    Ffator13: Double;
  public
    property fatorMes: Double read FfatorMes;
    property fator13: Double read Ffator13;
  end;

  TInfoPJ = class(TPersistent)
  private
    FindCoop: Integer;
    FindConstr: Integer;
    FindSubstPart: Integer;
    FpercRedContrib: Double;
    FinfoAtConc: TinfoAtConc;
  public
    constructor Create(AOwner: TInfoContrib); reintroduce;
    destructor Destroy; override;

    property indCoop: Integer read FindCoop;
    property indConstr: Integer read FindConstr;
    property indSubstPart: Integer read FindSubstPart;
    property percRedContrib: Double read FpercRedContrib;
    property infoAtConc: TinfoAtConc read FinfoAtConc write FinfoAtConc;
  end;

  TInfoContrib = class(TPersistent)
  private
    FclassTrib: String;
    FinfoPJ: TInfoPJ;
  public
    constructor Create(AOwner: TInfoCS); reintroduce;
    destructor Destroy; override;

    property classTrib: String read FclassTrib;
    property infoPJ: TInfoPJ read FinfoPJ write FinfoPJ;
  end;

  TInfoComplObra = class(TPersistent)
  private
    FindSubstPartObra: Integer;
  public
    property indSubstPartObra: Integer read FindSubstPartObra;
  end;

  TInfoEstab = class(TPersistent)
  private
    FFap: Double;
    FAliqRatAjust: Double;
    FcnaePrep: String;
    FAliqRat: tpAliqRat;
    FinfoComplObra: TInfoComplObra;
  public
    constructor Create(AOwner: TideEstabCollectionItem); reintroduce;
    destructor Destroy; override;

    property cnaePrep: String read FcnaePrep;
    property AliqRat: tpAliqRat read FAliqRat;
    property fap: Double read FFap;
    property aliqRatAjust: Double read FAliqRatAjust;
    property infoComplObra: TInfoComplObra read FinfoComplObra write FinfoComplObra;
  end;

  TinfoTercSuspCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TinfoTercSuspCollectionItem;
    procedure SetItem(Index: Integer; Value: TinfoTercSuspCollectionItem);
  public
    constructor Create; reintroduce;
    function Add: TinfoTercSuspCollectionItem;
    property Items[Index: Integer]: TinfoTercSuspCollectionItem read GetItem write SetItem;
  end;

  TinfoTercSuspCollectionItem = class(TCollectionItem)
  private
    FcodTerc: String;
  public
    property codTerc: String read FcodTerc;
  end;

  TideLotacaoCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TideLotacaoCollectionItem;
    procedure SetItem(Index: Integer; Value: TideLotacaoCollectionItem);
  public
    constructor Create; reintroduce;
    function Add: TideLotacaoCollectionItem;
    property Items[Index: Integer]: TideLotacaoCollectionItem read GetItem write SetItem;
  end;

  TInfoEmprParcial = class(TPersistent)
  private
    FtpinscContrat: Integer;
    FnrInscContrat: String;
    FtpInscProp: Integer;
    FnrInscProp: String;
  public
    property tpInscContrat: Integer read FtpinscContrat;
    property nrInscContrat: String read FnrInscContrat;
    property tpInscProp: Integer read FtpInscProp;
    property nrInscProp: String read FnrInscProp;
  end;

  TdadosOpPort = class(TPersistent)
  private
    FFap: Double;
    FAliqRatAjust: Double;
    FcnpjOpPortuario: String;
    FAliqRat: tpAliqRat;
  public
    property cnpjOpPortuario: String read FcnpjOpPortuario;
    property AliqRat: tpAliqRat read FAliqRat;
    property fap: Double read FFap;
    property aliqRatAjust: Double read FAliqRatAjust;
  end;

  TbasesCp = class(TPersistent)
  private
    FvrBcCp25: Double;
    FvrBcCp15: Double;
    FvrBcCp20: Double;
    FvrBcCp00: Double;
    FvrSuspBcCp00: Double;
    FvrSuspBcCp25: Double;
    FvrSuspBcCp15: Double;
    FvrSuspBcCp20: Double;
    FvrCalcSest: Double;
    FvrSalFam: Double;
    FvrDescSenat: Double;
    FvrCalcSenat: Double;
    FvrSalMat: Double;
    FvrDescSest: Double;
  public
    property vrBcCp00: Double read FvrBcCp00;
    property vrBcCp15: Double read FvrBcCp15;
    property vrBcCp20: Double read FvrBcCp20;
    property vrBcCp25: Double read FvrBcCp25;
    property vrSuspBcCp00: Double read FvrSuspBcCp00;
    property vrSuspBcCp15: Double read FvrSuspBcCp15;
    property vrSuspBcCp20: Double read FvrSuspBcCp20;
    property vrSuspBcCp25: Double read FvrSuspBcCp25;
    property vrDescSest: Double read FvrDescSest;
    property vrCalcSest: Double read FvrCalcSest;
    property vrDescSenat: Double read FvrDescSenat;
    property vrCalcSenat: Double read FvrCalcSenat;
    property vrSalFam: Double read FvrSalFam;
    property vrSalMat: Double read FvrSalMat;
  end;

  TbasesRemunCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TbasesRemunCollectionItem;
    procedure SetItem(Index: Integer; Value: TbasesRemunCollectionItem);
  public
    constructor Create(AOwner: TideLotacaoCollectionItem);
    function Add: TbasesRemunCollectionItem;
    property Items[Index: Integer]: TbasesRemunCollectionItem read GetItem write SetItem;
  end;

  TbasesRemunCollectionItem = class(TCollectionItem)
  private
    FindIncid: Integer;
    FcodCateg: Integer;
    FbasesCp: TbasesCp;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    property indIncid: Integer read FindIncid;
    property codCateg: Integer read FcodCateg;
    property basesCp: TbasesCp read FbasesCp write FbasesCp;
  end;

  TbasesAvNport = class(TPersistent)
  private
    FvrBcCp25: Double;
    FvrBcCp15: Double;
    FvrBcCp00: Double;
    FvrBcCp20: Double;
    FvrBcCp13: Double;
    FvrDescCP: Double;
    FvrBcFgts: Double;
  public
    property vrBcCp00: Double read FvrBcCp00;
    property vrBcCp15: Double read FvrBcCp15;
    property vrBcCp20: Double read FvrBcCp20;
    property vrBcCp25: Double read FvrBcCp25;
    property vrBcCp13: Double read FvrBcCp13;
    property vrBcFgts: Double read FvrBcFgts;
    property vrDescCP: Double read FvrDescCP;
  end;

  TinfoSubstPatrOpPortCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TinfoSubstPatrOpPortCollectionItem;
    procedure SetItem(Index: Integer; Value: TinfoSubstPatrOpPortCollectionItem);
  public
    constructor Create; reintroduce;
    function Add: TinfoSubstPatrOpPortCollectionItem;
    property Items[Index: Integer]: TinfoSubstPatrOpPortCollectionItem read GetItem write SetItem;
  end;

  TinfoSubstPatrOpPortCollectionItem = class(TCollectionItem)
  private
    FcnpjOpPortuario: String;
  public
    property cnpjOpPortuario: String read FcnpjOpPortuario;
  end;

  TideLotacaoCollectionItem = class(TCollectionItem)
  private
    Ffpas: Integer;
    FcodLotacao: String;
    FcodTercs: String;
    FcodTercsSusp: String;
    FinfoTercSusp: TinfoTercSuspCollection;
    FInfoEmprParcial: TInfoEmprParcial;
    FdadosOpPort: TdadosOpPort;
    Fbasesremun: TbasesremunCollection;
    FbasesAvNport: TbasesAvNport;
    FinfoSubstPatrOpPort: TinfoSubstPatrOpPortCollection;

    procedure Setbasesremun(const Value: TbasesremunCollection);
    procedure SetinfoSubstPatrOpPort(
      const Value: TinfoSubstPatrOpPortCollection);
    procedure SetinfoTercSusp(const Value: TinfoTercSuspCollection);
  public
    constructor Create(AOwner: TideEstabCollectionItem); reintroduce;
    destructor Destroy; override;

    property codLotacao: String read FcodLotacao;
    property fpas: Integer read Ffpas;
    property codTercs: String read FcodTercs;
    property codTercsSusp: String read FcodTercsSusp;
    property infoTercSusp: TinfoTercSuspCollection read FinfoTercSusp write SetinfoTercSusp;
    property InfoEmprParcial: TInfoEmprParcial read FInfoEmprParcial write FInfoEmprParcial;
    property dadosOpPort: TdadosOpPort read FdadosOpPort write FdadosOpPort;
    property basesremun: TbasesremunCollection read Fbasesremun write Setbasesremun;
    property basesAvNPort: TbasesAvNport read FbasesAvNport write FbasesAvNport;
    property infoSubstPatrOpPort: TinfoSubstPatrOpPortCollection read FinfoSubstPatrOpPort write SetinfoSubstPatrOpPort;
  end;

  TideEstabCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TideEstabCollectionItem;
    procedure SetItem(Index: Integer; Value: TideEstabCollectionItem);
  public
    constructor Create; reintroduce;
    function Add: TideEstabCollectionItem;
    property Items[Index: Integer]: TideEstabCollectionItem read GetItem write SetItem;
  end;

  TbasesAquisCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TbasesAquisCollectionItem;
    procedure SetItem(Index: Integer; Value: TbasesAquisCollectionItem);
  public
    constructor Create; reintroduce;
    function Add: TbasesAquisCollectionItem;
    property Items[Index: Integer]: TbasesAquisCollectionItem read GetItem write SetItem;
  end;

  TbasesAquisCollectionItem = class(TCollectionItem)
  private
    FvrSenarCalc: Double;
    FvrCPNRet: Double;
    FvrRatDescPR: Double;
    FvrRatCalcPR: Double;
    FvrCPDescPR: Double;
    FvrSenarDesc: Double;
    FvrSenarNRet: Double;
    FvrCPCalcPR: Double;
    FvrRatNRet: Double;
    FvlrAquis: Double;
    FindAquis: Integer;
  public
    property indAquis: Integer read FindAquis;
    property vlrAquis: Double read FvlrAquis;
    property vrCPDescPR: Double read FvrCPDescPR;
    property vrCPNRet: Double read FvrCPNRet;
    property vrRatNRet: Double read FvrRatNRet;
    property vrSenarNRet: Double read FvrSenarNRet;
    property vrCPCalcPR: Double read FvrCPCalcPR;
    property vrRatDescPR: Double read FvrRatDescPR;
    property vrRatCalcPR: Double read FvrRatCalcPR;
    property vrSenarDesc: Double read FvrSenarDesc;
    property vrSenarCalc: Double read FvrSenarCalc;
  end;

  TbasesComercCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TbasesComercCollectionItem;
    procedure SetItem(Index: Integer; Value: TbasesComercCollectionItem);
  public
    constructor Create; reintroduce;
    function Add: TbasesComercCollectionItem;
    property Items[Index: Integer]: TbasesComercCollectionItem read GetItem write SetItem;
  end;

  TbasesComercCollectionItem = class(TCollectionItem)
  private
    FvrCPSusp: Double;
    FvrRatSusp: Double;
    FvrSenarSusp: Double;
    FvrBcComPr: Double;
    FindComerc: Integer;
  public
    property indComerc: Integer read FindComerc;
    property vrBcComPr: Double read FvrBcComPr;
    property vrCPSusp: Double read FvrCPSusp;
    property vrRatSusp: Double read FvrRatSusp;
    property vrSenarSusp: Double read FvrSenarSusp;
  end;

  TinfoCREstabCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TinfoCREstabCollectionItem;
    procedure SetItem(Index: Integer; Value: TinfoCREstabCollectionItem);
  public
    constructor Create; reintroduce;
    function Add: TinfoCREstabCollectionItem;
    property Items[Index: Integer]: TinfoCREstabCollectionItem read GetItem write SetItem;
  end;

  TinfoCREstabCollectionItem = class(TCollectionItem)
  private
    FvrSuspCR: Double;
    FvrCR: Double;
    FtpCR: Integer;
  public
    property tpCR: Integer read FtpCR;
    property vrCR: Double read FvrCR;
    property vrSuspCR: Double read FvrSuspCR;
  end;

  TideEstabCollectionItem = class(TCollectionItem)
  private
    FNrInsc: string;
    FTpInsc: tpTpInsc;
    FinfoEstab: TinfoEstab;
    FideLotacao: TideLotacaoCollection;
    FbasesAquis: TbasesAquisCollection;
    FbasesComerc: TbasesComercCollection;
    FinfoCREstab: TinfoCREstabCollection;

    procedure SetbasesAquis(const Value: TbasesAquisCollection);
    procedure SetbasesComerc(const Value: TbasesComercCollection);
    procedure SetideLotacao(const Value: TideLotacaoCollection);
    procedure SetinfoCREstab(const Value: TinfoCREstabCollection);
  public
    constructor Create(AOwner: TInfoCS); reintroduce;
    destructor Destroy; override;

    property TpInsc: tpTpInsc read FTpInsc;
    property NrInsc: string read FNrInsc;
    property infoEstab: TinfoEstab read FinfoEstab write FinfoEstab;
    property ideLotacao: TideLotacaoCollection read FideLotacao write SetideLotacao;
    property basesAquis: TbasesAquisCollection read FbasesAquis write SetbasesAquis;
    property basesComerc: TbasesComercCollection read FbasesComerc write SetbasesComerc;
    property infoCREstab: TinfoCREstabCollection read FinfoCREstab write SetinfoCREstab;
  end;

  TInfoCRContribCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TInfoCRContribCollectionItem;
    procedure SetItem(Index: Integer; Value: TInfoCRContribCollectionItem);
  public
    constructor Create; reintroduce;
    function Add: TInfoCRContribCollectionItem;
    property Items[Index: Integer]: TInfoCRContribCollectionItem read GetItem write SetItem;
  end;

  TInfoCRContribCollectionItem = class(TCollectionItem)
  private
    FtpCR: string;
    FvrCR: Double;
    FvrCRSusp: Double;
  public
    property tpCR: string read FtpCR;
    property vrCR: Double read FvrCR;
    property vrCRSusp: Double read FvrCRSusp;
  end;

  TInfoCS = class(TPersistent)
  private
    FnrRecArqBase: String;
    FindExistInfo: Integer;
    FInfoCpSeg: TInfoCpSeg;
    FInfoContrib: TInfoContrib;
    FideEstab: TideEstabCollection;
    FinfoCRContrib: TinfoCRContribCollection;

    procedure SetideEstab(const Value: TideEstabCollection);
    procedure SetinfoCRContrib(const Value: TinfoCRContribCollection);
  public
    constructor Create(AOwner: TEvtCS);
    destructor Destroy; override;

    property nrRecArqBase: String read FnrRecArqBase;
    property indExistInfo: Integer read FindExistInfo;
    property InfoCpSeg: TInfoCpSeg read FInfoCpSeg write FInfoCpSeg;
    property InfoContrib: TInfoContrib read FInfoContrib write FInfoContrib;
    property ideEstab: TideEstabCollection read FideEstab write SetideEstab;
    property infoCRContrib: TinfoCRContribCollection read FinfoCRContrib write SetinfoCRContrib;
  end;

  TEvtCS = class(TPersistent)
  private
    FLeitor: TLeitor;
    FId: String;
    FXML: String;

    FIdeEvento: TIdeEvento5;
    FIdeEmpregador: TIdeEmpregador;
    FIdeTrabalhador: TIdeTrabalhador3;
    FInfoCS: TInfoCS;
  public
    constructor Create;
    destructor  Destroy; override;

    function LerXML: boolean;
    function SalvarINI: boolean;

    property IdeEvento: TIdeEvento5 read FIdeEvento write FIdeEvento;
    property IdeEmpregador: TIdeEmpregador read FIdeEmpregador write FIdeEmpregador;
    property IdeTrabalhador: TIdeTrabalhador3 read FIdeTrabalhador write FIdeTrabalhador;
    property InfoCS: TInfoCS read FInfoCS write FInfoCS;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property Id: String      read FId;
    property XML: String     read FXML;
  end;

implementation

uses
  IniFiles;

{ TS5011 }

constructor TS5011.Create;
begin
  FTipoEvento := teS5011;
  FEvtCS := TEvtCS.Create;
end;

destructor TS5011.Destroy;
begin
  FEvtCS.Free;

  inherited;
end;

function TS5011.GetEvento : TObject;
begin
  Result := self;
end;

function TS5011.GetXml : string;
begin
  Result := FEvtCS.XML;
end;

procedure TS5011.SetXml(const Value: string);
begin
  if Value = FEvtCS.XML then Exit;

  FEvtCS.FXML := Value;
  FEvtCS.Leitor.Arquivo := Value;
  FEvtCS.LerXML;

end;

function TS5011.GetTipoEvento : TTipoEvento;
begin
  Result := FTipoEvento;
end;

procedure TS5011.SetEvtCS(const Value: TEvtCS);
begin
  FEvtCS.Assign(Value);
end;

{ TEvtCS }

constructor TEvtCS.Create;
begin
  FLeitor := TLeitor.Create;

  FIdeEvento := TIdeEvento5.Create;
  FIdeEmpregador := TIdeEmpregador.Create;
  FIdeTrabalhador := TIdeTrabalhador3.Create;
  FInfoCS := TInfoCS.Create(Self);
end;

destructor TEvtCS.Destroy;
begin
  FLeitor.Free;

  FIdeEvento.Free;
  FIdeEmpregador.Free;
  FIdeTrabalhador.Free;
  FInfoCS.Free;

  inherited;
end;

{ TInfoCS }

constructor TInfoCS.Create;
begin
  FInfoCpSeg := TInfoCpSeg.Create;
  FInfoContrib := TInfoContrib.Create(Self);
  FideEstab := TideEstabCollection.Create;
  FinfoCRContrib := TinfoCRContribCollection.Create;
end;

destructor TInfoCS.Destroy;
begin
  FInfoCpSeg.Free;
  FInfoContrib.Free;
  FideEstab.Free;
  FinfoCRContrib.Free;

  inherited;
end;

procedure TInfoCS.SetideEstab(const Value: TideEstabCollection);
begin
  FideEstab := Value;
end;

procedure TInfoCS.SetinfoCRContrib(const Value: TinfoCRContribCollection);
begin
  FinfoCRContrib := Value;
end;

{ TInfoContrib }

constructor TInfoContrib.Create(AOwner: TInfoCS);
begin
  FInfoPJ := TInfoPJ.Create(Self);
end;

destructor TInfoContrib.Destroy;
begin
  FInfoPJ.Free;

  inherited;
end;

{ TInfoPJ }

constructor TInfoPJ.Create(AOwner: TInfoContrib);
begin
  FinfoAtConc := TinfoAtConc.Create;
end;

destructor TInfoPJ.Destroy;
begin
  FinfoAtConc.Free;
  
  inherited;
end;

{ TideEstabCollection }

function TideEstabCollection.Add: TideEstabCollectionItem;
begin
  Result := TideEstabCollectionItem(inherited Add);
end;

constructor TideEstabCollection.Create;
begin
  inherited create(TideEstabCollectionItem);
end;

function TideEstabCollection.GetItem(
  Index: Integer): TideEstabCollectionItem;
begin
  Result := TideEstabCollectionItem(inherited GetItem(Index));
end;

procedure TideEstabCollection.SetItem(Index: Integer;
  Value: TideEstabCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TbasesAquisCollection }

function TbasesAquisCollection.Add: TbasesAquisCollectionItem;
begin
  Result := TbasesAquisCollectionItem(inherited Add);
end;

constructor TbasesAquisCollection.Create;
begin
  inherited create(TbasesAquisCollectionItem);
end;

function TbasesAquisCollection.GetItem(
  Index: Integer): TbasesAquisCollectionItem;
begin
  Result := TbasesAquisCollectionItem(inherited GetItem(Index));
end;

procedure TbasesAquisCollection.SetItem(Index: Integer;
  Value: TbasesAquisCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TbasesComercCollection }

function TbasesComercCollection.Add: TbasesComercCollectionItem;
begin
  Result := TbasesComercCollectionItem(inherited Add);
end;

constructor TbasesComercCollection.Create;
begin
  inherited create(TbasesComercCollectionItem);
end;

function TbasesComercCollection.GetItem(
  Index: Integer): TbasesComercCollectionItem;
begin
  Result := TbasesComercCollectionItem(inherited GetItem(Index));
end;

procedure TbasesComercCollection.SetItem(Index: Integer;
  Value: TbasesComercCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TinfoCREstabCollection }

function TinfoCREstabCollection.Add: TinfoCREstabCollectionItem;
begin
  Result := TinfoCREstabCollectionItem(inherited Add);
end;

constructor TinfoCREstabCollection.Create;
begin
  inherited create(TinfoCREstabCollectionItem);
end;

function TinfoCREstabCollection.GetItem(
  Index: Integer): TinfoCREstabCollectionItem;
begin
  Result := TinfoCREstabCollectionItem(inherited GetItem(Index));
end;

procedure TinfoCREstabCollection.SetItem(Index: Integer;
  Value: TinfoCREstabCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TideEstabCollectionItem }

constructor TideEstabCollectionItem.Create(AOwner: TInfoCS);
begin
  FInfoEstab := TInfoEstab.Create(Self);
  FideLotacao := TideLotacaoCollection.Create;
  FbasesAquis := TbasesAquiscollection.Create;
  FbasesComerc := TbasesComercCollection.Create;
  FinfoCREstab := TinfoCREstabCollection.Create;
end;

destructor TideEstabCollectionItem.Destroy;
begin
  FInfoEstab.Free;
  FideLotacao.Free;
  FbasesAquis.Free;
  FbasesComerc.Free;
  FinfoCREstab.Free;

  inherited;
end;

procedure TideEstabCollectionItem.SetbasesAquis(
  const Value: TbasesAquisCollection);
begin
  FbasesAquis := Value;
end;

procedure TideEstabCollectionItem.SetbasesComerc(
  const Value: TbasesComercCollection);
begin
  FbasesComerc := Value;
end;

procedure TideEstabCollectionItem.SetideLotacao(
  const Value: TideLotacaoCollection);
begin
  FideLotacao := Value;
end;

procedure TideEstabCollectionItem.SetinfoCREstab(
  const Value: TinfoCREstabCollection);
begin
  FinfoCREstab := Value;
end;

{ TideLotacaoCollection }

function TideLotacaoCollection.Add: TideLotacaoCollectionItem;
begin
  Result := TideLotacaoCollectionItem(inherited Add);
end;

constructor TideLotacaoCollection.Create;
begin
  inherited create(TideLotacaoCollectionItem);
end;

function TideLotacaoCollection.GetItem(
  Index: Integer): TideLotacaoCollectionItem;
begin
  Result := TideLotacaoCollectionItem(inherited GetItem(Index));
end;

procedure TideLotacaoCollection.SetItem(Index: Integer;
  Value: TideLotacaoCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TinfoTercSuspCollection }

function TinfoTercSuspCollection.Add: TinfoTercSuspCollectionItem;
begin
  Result := TinfoTercSuspCollectionItem(inherited Add);
end;

constructor TinfoTercSuspCollection.Create;
begin
  inherited create(TinfoTercSuspCollectionItem);
end;

function TinfoTercSuspCollection.GetItem(
  Index: Integer): TinfoTercSuspCollectionItem;
begin
  Result := TinfoTercSuspCollectionItem(inherited GetItem(Index));
end;

procedure TinfoTercSuspCollection.SetItem(Index: Integer;
  Value: TinfoTercSuspCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TbasesRemunCollection }

function TbasesRemunCollection.Add: TbasesRemunCollectionItem;
begin
  Result := TbasesRemunCollectionItem(inherited Add);
end;

constructor TbasesRemunCollection.Create(
  AOwner: TideLotacaoCollectionItem);
begin
  inherited create(TbasesRemunCollectionItem);
end;

function TbasesRemunCollection.GetItem(
  Index: Integer): TbasesRemunCollectionItem;
begin
  Result := TbasesRemunCollectionItem(inherited GetItem(Index));
end;

procedure TbasesRemunCollection.SetItem(Index: Integer;
  Value: TbasesRemunCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TbasesRemunCollectionItem }

constructor TbasesRemunCollectionItem.Create;
begin
  FbasesCp := TbasesCp.Create;
end;

destructor TbasesRemunCollectionItem.Destroy;
begin
  FbasesCp.Free;

  inherited;
end;

{ TinfoSubstPatrOpPortCollection }

function TinfoSubstPatrOpPortCollection.Add: TinfoSubstPatrOpPortCollectionItem;
begin
  Result := TinfoSubstPatrOpPortCollectionItem(inherited Add);
end;

constructor TinfoSubstPatrOpPortCollection.Create;
begin
  inherited create(TinfoSubstPatrOpPortCollectionItem);
end;

function TinfoSubstPatrOpPortCollection.GetItem(
  Index: Integer): TinfoSubstPatrOpPortCollectionItem;
begin
  Result := TinfoSubstPatrOpPortCollectionItem(inherited GetItem(Index));
end;

procedure TinfoSubstPatrOpPortCollection.SetItem(Index: Integer;
  Value: TinfoSubstPatrOpPortCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TideLotacaoCollectionItem }

constructor TideLotacaoCollectionItem.Create(
  AOwner: TideEstabCollectionItem);
begin
  FinfoTercSusp := TinfoTercSuspCollection.Create;
  FInfoEmprParcial := TInfoEmprParcial.Create;
  FdadosOpPort := TdadosOpPort.Create;
  Fbasesremun := TbasesremunCollection.Create(Self);
  FbasesAvNport := TbasesAvNport.Create;
  FinfoSubstPatrOpPort := TinfoSubstPatrOpPortCollection.Create;
end;

destructor TideLotacaoCollectionItem.Destroy;
begin
  FinfoTercSusp.Free;
  FInfoEmprParcial.Free;
  FdadosOpPort.Free;
  Fbasesremun.Free;
  FbasesAvNport.Free;
  FinfoSubstPatrOpPort.Free;

  inherited;
end;

procedure TideLotacaoCollectionItem.Setbasesremun(
  const Value: TbasesremunCollection);
begin
  Fbasesremun := Value;
end;

procedure TideLotacaoCollectionItem.SetinfoSubstPatrOpPort(
  const Value: TinfoSubstPatrOpPortCollection);
begin
  FinfoSubstPatrOpPort := Value;
end;

procedure TideLotacaoCollectionItem.SetinfoTercSusp(
  const Value: TinfoTercSuspCollection);
begin
  FinfoTercSusp := Value;
end;

{ TInfoEstab }

constructor TInfoEstab.Create(AOwner: TideEstabCollectionItem);
begin
  FinfoComplObra := TinfoComplObra.Create;
end;

destructor TInfoEstab.Destroy;
begin
  FinfoComplObra.Free;

  inherited;
end;

{ TInfoCRContribCollection }

function TInfoCRContribCollection.Add: TInfoCRContribCollectionItem;
begin
  Result := TInfoCRContribCollectionItem(inherited Add);
end;

constructor TInfoCRContribCollection.Create;
begin
  inherited create(TInfoCRContribCollectionItem);
end;

function TInfoCRContribCollection.GetItem(
  Index: Integer): TInfoCRContribCollectionItem;
begin
  Result := TInfoCRContribCollectionItem(inherited GetItem(Index));
end;

procedure TInfoCRContribCollection.SetItem(Index: Integer;
  Value: TInfoCRContribCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

function TEvtCS.LerXML: boolean;
var
  ok: Boolean;
  i, j, k: Integer;
begin
  Result := False;
  try
    FXML := Leitor.Arquivo;

    if leitor.rExtrai(1, 'evtCS') <> '' then
    begin
      FId := Leitor.rAtributo('Id=');

      if leitor.rExtrai(2, 'ideEvento') <> '' then
      begin
        IdeEvento.IndApuracao := eSStrToIndApuracao(ok, leitor.rCampo(tcStr, 'IndApuracao'));
        IdeEvento.perApur     := leitor.rCampo(tcStr, 'perApur');
      end;

      if leitor.rExtrai(2, 'ideEmpregador') <> '' then
      begin
        IdeEmpregador.TpInsc := eSStrToTpInscricao(ok, leitor.rCampo(tcStr, 'tpInsc'));
        IdeEmpregador.NrInsc := leitor.rCampo(tcStr, 'nrInsc');
      end;

      if leitor.rExtrai(2, 'infoCS') <> '' then
      begin
        infoCS.FnrRecArqBase := leitor.rCampo(tcStr, 'nrRecArqBase');
        infoCS.FindExistInfo := leitor.rCampo(tcInt, 'indExistInfo');

        if leitor.rExtrai(3, 'infoCPSeg') <> '' then
        begin
          infoCS.InfoCpSeg.vrDescCP := leitor.rCampo(tcDe2, 'vrDescCP');
          infoCS.InfoCpSeg.vrCpSeg  := leitor.rCampo(tcDe2, 'vrCpSeg');
        end;

        if leitor.rExtrai(3, 'infoContrib') <> '' then
        begin
          infoCS.InfoContrib.FclassTrib := leitor.rCampo(tcStr, 'classTrib');

          if leitor.rExtrai(4, 'infoPJ') <> '' then
          begin
            infoCS.InfoContrib.infoPJ.FindCoop        := leitor.rCampo(tcInt, 'indCoop');
            infoCS.InfoContrib.infoPJ.FindConstr      := leitor.rCampo(tcInt, 'indConstr');
            infoCS.InfoContrib.infoPJ.FindSubstPart   := leitor.rCampo(tcInt, 'indSubstPart');
            infoCS.InfoContrib.infoPJ.FpercRedContrib := leitor.rCampo(tcDe2, 'percRedContrib');

            if leitor.rExtrai(5, 'infoAtConc') <> '' then
            begin
              infoCS.InfoContrib.infoPJ.infoAtConc.FfatorMes := leitor.rCampo(tcDe4, 'fatorMes');
              infoCS.InfoContrib.infoPJ.infoAtConc.Ffator13  := leitor.rCampo(tcDe2, 'fator13');
            end;
          end;
        end;

        i := 0;
        while Leitor.rExtrai(3, 'ideEstab', '', i + 1) <> '' do
        begin
          infoCS.ideEstab.Add;
          infoCS.ideEstab.Items[i].FTpInsc := eSStrToTpInscricao(ok, leitor.rCampo(tcStr, 'tpInsc'));
          infoCS.ideEstab.Items[i].FNrInsc := leitor.rCampo(tcStr, 'nrInsc');

          if leitor.rExtrai(4, 'infoEstab') <> '' then
          begin
            infoCS.ideEstab.Items[i].infoEstab.FcnaePrep     := leitor.rCampo(tcStr, 'cnaePrep');
            infoCS.ideEstab.Items[i].infoEstab.FAliqRat      := eSStrToAliqRat(ok, leitor.rCampo(tcStr, 'AliqRat'));
            infoCS.ideEstab.Items[i].infoEstab.Ffap          := leitor.rCampo(tcDe4, 'fap');
            infoCS.ideEstab.Items[i].infoEstab.FaliqRatAjust := leitor.rCampo(tcDe4, 'aliqRatAjust');

            if leitor.rExtrai(5, 'infoComplObra') <> '' then
              infoCS.ideEstab.Items[i].infoEstab.infoComplObra.FindSubstPartObra := leitor.rCampo(tcInt, 'indSubstPartObra');

            j := 0;
            while Leitor.rExtrai(5, 'ideLotacao', '', i + 1) <> '' do
            begin
              infoCS.ideEstab.Items[i].ideLotacao.Add;
              infoCS.ideEstab.Items[i].ideLotacao.Items[j].FcodLotacao   := leitor.rCampo(tcStr, 'codLotacao');
              infoCS.ideEstab.Items[i].ideLotacao.Items[j].Ffpas         := leitor.rCampo(tcInt, 'fpas');
              infoCS.ideEstab.Items[i].ideLotacao.Items[j].FcodTercs     := leitor.rCampo(tcStr, 'codTercs');
              infoCS.ideEstab.Items[i].ideLotacao.Items[j].FcodTercsSusp := leitor.rCampo(tcStr, 'codTercsSusp');

              k := 0;
              while Leitor.rExtrai(6, 'infoTercSusp', '', i + 1) <> '' do
              begin
                infoCS.ideEstab.Items[i].ideLotacao.Items[j].infoTercSusp.Add;
                infoCS.ideEstab.Items[i].ideLotacao.Items[j].infoTercSusp.Items[k].FcodTerc := leitor.rCampo(tcStr, 'codTerc');
                inc(k);
              end;

              if leitor.rExtrai(6, 'infoEmprParcial') <> '' then
              begin
                infoCS.ideEstab.Items[i].ideLotacao.Items[j].InfoEmprParcial.FtpInscContrat := leitor.rCampo(tcInt, 'tpInscContrat');
                infoCS.ideEstab.Items[i].ideLotacao.Items[j].InfoEmprParcial.FnrInscContrat := leitor.rCampo(tcStr, 'nrInscContrat');
                infoCS.ideEstab.Items[i].ideLotacao.Items[j].InfoEmprParcial.FtpInscProp    := leitor.rCampo(tcInt, 'tpInscProp');
                infoCS.ideEstab.Items[i].ideLotacao.Items[j].InfoEmprParcial.FnrInscProp    := leitor.rCampo(tcStr, 'nrInscProp');
              end;

              if leitor.rExtrai(6, 'dadosOpPort') <> '' then
              begin
                infoCS.ideEstab.Items[i].ideLotacao.Items[j].dadosOpPort.FcnpjOpPortuario := leitor.rCampo(tcStr, 'cnpjOpPortuario');
                infoCS.ideEstab.Items[i].ideLotacao.Items[j].dadosOpPort.FAliqRat         := eSStrToAliqRat(ok, leitor.rCampo(tcStr, 'AliqRat'));
                infoCS.ideEstab.Items[i].ideLotacao.Items[j].dadosOpPort.Ffap             := leitor.rCampo(tcDe4, 'fap');
                infoCS.ideEstab.Items[i].ideLotacao.Items[j].dadosOpPort.FaliqRatAjust    := leitor.rCampo(tcDe4, 'aliqRatAjust');
              end;

              k := 0;
              while Leitor.rExtrai(6, 'basesRemun', '', i + 1) <> '' do
              begin
                infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesRemun.Add;
                infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesRemun.Items[k].FindIncid := leitor.rCampo(tcInt, 'indIncid');
                infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesRemun.Items[k].FcodCateg := leitor.rCampo(tcInt, 'codCateg');

                if leitor.rExtrai(7, 'basesCp') <> '' then
                begin
                  infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesRemun.Items[k].basesCp.FvrBcCp00 := leitor.rCampo(tcDe2, 'vrBcCp00');
                  infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesRemun.Items[k].basesCp.FvrBcCp15 := leitor.rCampo(tcDe2, 'vrBcCp15');
                  infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesRemun.Items[k].basesCp.FvrBcCp20 := leitor.rCampo(tcDe2, 'vrBcCp20');
                  infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesRemun.Items[k].basesCp.FvrBcCp25 := leitor.rCampo(tcDe2, 'vrBcCp25');

                  infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesRemun.Items[k].basesCp.FvrSuspBcCp00 := leitor.rCampo(tcDe2, 'vrSuspBcCp00');
                  infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesRemun.Items[k].basesCp.FvrSuspBcCp15 := leitor.rCampo(tcDe2, 'vrSuspBcCp15');
                  infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesRemun.Items[k].basesCp.FvrSuspBcCp20 := leitor.rCampo(tcDe2, 'vrSuspBcCp20');
                  infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesRemun.Items[k].basesCp.FvrSuspBcCp25 := leitor.rCampo(tcDe2, 'vrSuspBcCp25');

                  infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesRemun.Items[k].basesCp.FvrDescSest  := leitor.rCampo(tcDe2, 'vrDescSest');
                  infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesRemun.Items[k].basesCp.FvrCalcSest  := leitor.rCampo(tcDe2, 'vrCalcSest');
                  infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesRemun.Items[k].basesCp.FvrDescSenat := leitor.rCampo(tcDe2, 'vrDescSenat');
                  infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesRemun.Items[k].basesCp.FvrCalcSenat := leitor.rCampo(tcDe2, 'vrCalcSenat');

                  infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesRemun.Items[k].basesCp.FvrSalFam := leitor.rCampo(tcDe2, 'vrSalFam');
                  infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesRemun.Items[k].basesCp.FvrSalMat := leitor.rCampo(tcDe2, 'vrSalMat');
                end;

                inc(k);
              end;

              if leitor.rExtrai(6, 'basesAvNPort') <> '' then
              begin
                infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesAvNPort.FvrBcCp00 := leitor.rCampo(tcDe2, 'vrBcCp00');
                infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesAvNPort.FvrBcCp15 := leitor.rCampo(tcDe2, 'vrBcCp15');
                infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesAvNPort.FvrBcCp20 := leitor.rCampo(tcDe2, 'vrBcCp20');
                infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesAvNPort.FvrBcCp25 := leitor.rCampo(tcDe2, 'vrBcCp25');
                infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesAvNPort.FvrBcCp13 := leitor.rCampo(tcDe2, 'vrBcCp13');

                infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesAvNPort.FvrBcFgts := leitor.rCampo(tcDe2, 'vrBcFgts');
                infoCS.ideEstab.Items[i].ideLotacao.Items[j].basesAvNPort.FvrDescCP := leitor.rCampo(tcDe2, 'vrDescCP');
              end;

              k := 0;
              while Leitor.rExtrai(6, 'infoSubstPatrOpPort', '', i + 1) <> '' do
              begin
                infoCS.ideEstab.Items[i].ideLotacao.Items[j].infoSubstPatrOpPort.Add;
                infoCS.ideEstab.Items[i].ideLotacao.Items[j].infoSubstPatrOpPort.Items[k].FcnpjOpPortuario := leitor.rCampo(tcStr, 'cnpjOpPortuario');
                inc(k);
              end;

              inc(j);
            end;
          end;

          j := 0;
          while Leitor.rExtrai(4, 'basesAquis', '', i + 1) <> '' do
          begin
            infoCS.ideEstab.Items[i].basesAquis.Add;
            infoCS.ideEstab.Items[i].basesAquis.Items[j].FindAquis    := leitor.rCampo(tcInt, 'indAquis');
            infoCS.ideEstab.Items[i].basesAquis.Items[j].FvlrAquis    := leitor.rCampo(tcDe2, 'vlrAquis');
            infoCS.ideEstab.Items[i].basesAquis.Items[j].FvrCPDescPR  := leitor.rCampo(tcDe2, 'vrCPDescPR');
            infoCS.ideEstab.Items[i].basesAquis.Items[j].FvrCPNRet    := leitor.rCampo(tcDe2, 'vrCPNRet');
            infoCS.ideEstab.Items[i].basesAquis.Items[j].FvrRatNRet   := leitor.rCampo(tcDe2, 'vrRatNRet');
            infoCS.ideEstab.Items[i].basesAquis.Items[j].FvrSenarNRet := leitor.rCampo(tcDe2, 'vrSenarNRet');
            infoCS.ideEstab.Items[i].basesAquis.Items[j].FvrCPCalcPR  := leitor.rCampo(tcDe2, 'vrCPCalcPR');
            infoCS.ideEstab.Items[i].basesAquis.Items[j].FvrRatDescPR := leitor.rCampo(tcDe2, 'vrRatDescPR');
            infoCS.ideEstab.Items[i].basesAquis.Items[j].FvrRatCalcPR := leitor.rCampo(tcDe2, 'vrRatCalcPR');
            infoCS.ideEstab.Items[i].basesAquis.Items[j].FvrSenarDesc := leitor.rCampo(tcDe2, 'vrSenarDesc');
            infoCS.ideEstab.Items[i].basesAquis.Items[j].FvrSenarCalc := leitor.rCampo(tcDe2, 'vrSenarCalc');
            inc(j);
          end;

          j := 0;
          while Leitor.rExtrai(4, 'basesComerc', '', i + 1) <> '' do
          begin
            infoCS.ideEstab.Items[i].basesComerc.Add;
            infoCS.ideEstab.Items[i].basesComerc.Items[j].FindComerc   := leitor.rCampo(tcInt, 'indComerc');
            infoCS.ideEstab.Items[i].basesComerc.Items[j].FvrBcComPr   := leitor.rCampo(tcDe2, 'vrBcComPr');
            infoCS.ideEstab.Items[i].basesComerc.Items[j].FvrCPSusp    := leitor.rCampo(tcDe2, 'vrCPSusp');
            infoCS.ideEstab.Items[i].basesComerc.Items[j].FvrRatSusp   := leitor.rCampo(tcDe2, 'vrRatSusp');
            infoCS.ideEstab.Items[i].basesComerc.Items[j].FvrSenarSusp := leitor.rCampo(tcDe2, 'vrSenarSusp');
            inc(j);
          end;

          j := 0;
          while Leitor.rExtrai(4, 'infoCREstab', '', i + 1) <> '' do
          begin
            infoCS.ideEstab.Items[i].infoCREstab.Add;
            infoCS.ideEstab.Items[i].infoCREstab.Items[j].FtpCR     := leitor.rCampo(tcInt, 'tpCR');
            infoCS.ideEstab.Items[i].infoCREstab.Items[j].FvrCR     := leitor.rCampo(tcDe2, 'vrCR');
            infoCS.ideEstab.Items[i].infoCREstab.Items[j].FvrSuspCR := leitor.rCampo(tcDe2, 'vrSuspCR');
            inc(j);
          end;

          inc(i);
        end;

        i := 0;
        while Leitor.rExtrai(3, 'infoCRContrib', '', i + 1) <> '' do
        begin
          infoCS.infoCRContrib.Add;
          infoCS.infoCRContrib.Items[i].FtpCR     := leitor.rCampo(tcStr, 'tpCR');
          infoCS.infoCRContrib.Items[i].FvrCR     := leitor.rCampo(tcDe2, 'vrCR');
          infoCS.infoCRContrib.Items[i].FvrCRSusp := leitor.rCampo(tcDe2, 'vrCRSusp');
          inc(i);
        end;
      end;

      Result := True;
    end;
  except
    Result := False;
  end;
end;

function TEvtCS.SalvarINI: boolean;
var
  AIni: TMemIniFile;
  sSecao: String;
  i, j, k: Integer;
begin
  Result := False;

  AIni := TMemIniFile.Create('');
  try
    Result := True;

    with Self do
    begin
      sSecao := 'evtCS';
      AIni.WriteString(sSecao, 'Id', Id);

      sSecao := 'ideEvento';
      AIni.WriteString(sSecao, 'IndApuracao', eSIndApuracaoToStr(IdeEvento.IndApuracao));
      AIni.WriteString(sSecao, 'perApur',     IdeEvento.perApur);

      sSecao := 'ideEmpregador';
      AIni.WriteString(sSecao, 'tpInsc', eSTpInscricaoToStr(IdeEmpregador.TpInsc));
      AIni.WriteString(sSecao, 'nrInsc', IdeEmpregador.nrInsc);

      sSecao := 'infoCS';
      AIni.WriteString(sSecao, 'nrRecArqBase',  infoCS.nrRecArqBase);
      AIni.WriteInteger(sSecao, 'indExistInfo', infoCS.indExistInfo);

      sSecao := 'infoCPSeg';
      AIni.WriteFloat(sSecao, 'vrDescCP', infoCS.infoCPSeg.vrDescCP);
      AIni.WriteFloat(sSecao, 'vrCpSeg',  infoCS.infoCPSeg.vrCpSeg);

      sSecao := 'infoContrib';
      AIni.WriteString(sSecao, 'classTrib', infoCS.infoContrib.classTrib);

      sSecao := 'infoPJ';
      AIni.WriteInteger(sSecao, 'indCoop',      infoCS.infoContrib.infoPJ.indCoop);
      AIni.WriteInteger(sSecao, 'indConstr',    infoCS.infoContrib.infoPJ.indConstr);
      AIni.WriteInteger(sSecao, 'indSubstPart', infoCS.infoContrib.infoPJ.indSubstPart);
      AIni.WriteFloat(sSecao, 'percRedContrib', infoCS.infoContrib.infoPJ.percRedContrib);

      sSecao := 'infoAtConc';
      AIni.WriteFloat(sSecao, 'fatorMes', infoCS.infoContrib.infoPJ.infoAtConc.fatorMes);
      AIni.WriteFloat(sSecao, 'fator13',  infoCS.infoContrib.infoPJ.infoAtConc.fator13);

      for i := 0 to infoCS.ideEstab.Count -1 do
      begin
        sSecao := 'ideEstab' + IntToStrZero(I, 4);

        AIni.WriteString(sSecao, 'tpInsc', eSTpInscricaoToStr(infoCS.ideEstab.Items[i].TpInsc));
        AIni.WriteString(sSecao, 'nrInsc', infoCS.ideEstab.Items[i].nrInsc);

        sSecao := 'infoEstab' + IntToStrZero(I, 4);

        AIni.WriteString(sSecao, 'cnaePrep',    infoCS.ideEstab.Items[i].infoEstab.cnaePrep);
        AIni.WriteString(sSecao, 'aliqRat',     eSAliqRatToStr(infoCS.ideEstab.Items[i].infoEstab.AliqRat));
        AIni.WriteFloat(sSecao, 'fap',          infoCS.ideEstab.Items[i].infoEstab.fap);
        AIni.WriteFloat(sSecao, 'aliqRatAjust', infoCS.ideEstab.Items[i].infoEstab.aliqRatAjust);

        sSecao := 'infoComplObra' + IntToStrZero(I, 4);

        AIni.WriteInteger(sSecao, 'indSubstPartObra', infoCS.ideEstab.Items[i].infoEstab.infoComplObra.indSubstPartObra);

        with infoCS.ideEstab.Items[i] do
        begin
          for j := 0 to ideLotacao.Count -1 do
          begin
            sSecao := 'ideLotacao' + IntToStrZero(I, 4) + IntToStrZero(j, 2);

            AIni.WriteString(sSecao, 'codLotacao',   ideLotacao.Items[j].codLotacao);
            AIni.WriteInteger(sSecao, 'fpas',        ideLotacao.Items[j].fpas);
            AIni.WriteString(sSecao, 'codTercs',     ideLotacao.Items[j].codTercs);
            AIni.WriteString(sSecao, 'codTercsSusp', ideLotacao.Items[j].codTercsSusp);

            with ideLotacao.Items[j] do
            begin
              for k := 0 to infoTercSusp.Count -1 do
              begin
                with infoTercSusp.Items[k] do
                begin
                  sSecao := 'infoTercSusp' + IntToStrZero(I, 4) + IntToStrZero(j, 2) +
                          IntToStrZero(k, 2);

                  AIni.WriteString(sSecao, 'codTerc', codTerc);
                end;
              end;

              sSecao := 'infoEmprParcial' + IntToStrZero(I, 4) + IntToStrZero(j, 2);

              AIni.WriteInteger(sSecao, 'tpInscContrat', infoEmprParcial.tpInscContrat);
              AIni.WriteString(sSecao, 'nrInscContrat',  infoEmprParcial.nrInscContrat);
              AIni.WriteInteger(sSecao, 'tpInscProp',    infoEmprParcial.tpInscProp);
              AIni.WriteString(sSecao, 'nrInscProp',     infoEmprParcial.nrInscProp);

              sSecao := 'dadosOpPort' + IntToStrZero(I, 4) + IntToStrZero(j, 2);

              AIni.WriteString(sSecao, 'cnpjOpPortuario', dadosOpPort.cnpjOpPortuario);
              AIni.WriteString(sSecao, 'nrInscContrat',   eSAliqRatToStr(dadosOpPort.AliqRat));
              AIni.WriteFloat(sSecao, 'fap',              dadosOpPort.fap);
              AIni.WriteFloat(sSecao, 'aliqRatAjust',     dadosOpPort.aliqRatAjust);

              for k := 0 to basesremun.Count -1 do
              begin
                with basesremun.Items[k] do
                begin
                  sSecao := 'basesRemun' + IntToStrZero(I, 4) + IntToStrZero(j, 2) +
                          IntToStrZero(k, 2);

                  AIni.WriteInteger(sSecao, 'indincid', indincid);
                  AIni.WriteInteger(sSecao, 'codCateg',  codCateg);

                  sSecao := 'basesCp' + IntToStrZero(I, 4) + IntToStrZero(j, 2) +
                          IntToStrZero(k, 2);

                  with basesCp do
                  begin
                    AIni.WriteFloat(sSecao, 'vrBcCp00',     vrBcCp00);
                    AIni.WriteFloat(sSecao, 'vrBcCp15',     vrBcCp15);
                    AIni.WriteFloat(sSecao, 'vrBcCp20',     vrBcCp20);
                    AIni.WriteFloat(sSecao, 'vrBcCp25',     vrBcCp25);
                    AIni.WriteFloat(sSecao, 'vrSuspBcCp00', vrSuspBcCp00);
                    AIni.WriteFloat(sSecao, 'vrSuspBcCp15', vrSuspBcCp15);
                    AIni.WriteFloat(sSecao, 'vrSuspBcCp20', vrSuspBcCp20);
                    AIni.WriteFloat(sSecao, 'vrSuspBcCp25', vrSuspBcCp25);
                    AIni.WriteFloat(sSecao, 'vrDescSest',   vrDescSest);
                    AIni.WriteFloat(sSecao, 'vrCalcSest',   vrCalcSest);
                    AIni.WriteFloat(sSecao, 'vrDescSenat',  vrDescSenat);
                    AIni.WriteFloat(sSecao, 'vrCalcSenat',  vrCalcSenat);
                    AIni.WriteFloat(sSecao, 'vrSalFam',     vrSalFam);
                    AIni.WriteFloat(sSecao, 'vrSalMat',     vrSalMat);
                  end;
                end;
              end;

              sSecao := 'basesAvNPort' + IntToStrZero(I, 4) + IntToStrZero(j, 2);

              with basesAvNPort do
              begin
                AIni.WriteFloat(sSecao, 'vrBcCp00', vrBcCp00);
                AIni.WriteFloat(sSecao, 'vrBcCp15', vrBcCp15);
                AIni.WriteFloat(sSecao, 'vrBcCp20', vrBcCp20);
                AIni.WriteFloat(sSecao, 'vrBcCp25', vrBcCp25);
                AIni.WriteFloat(sSecao, 'vrBcCp13', vrBcCp13);
                AIni.WriteFloat(sSecao, 'vrBcFgts', vrBcFgts);
                AIni.WriteFloat(sSecao, 'vrDescCP', vrDescCP);
              end;

              for k := 0 to infoSubstPatrOpPort.Count -1 do
              begin
                with infoSubstPatrOpPort.Items[k] do
                begin
                  sSecao := 'infoSubstPatrOpPort' + IntToStrZero(I, 4) + IntToStrZero(j, 2) +
                          IntToStrZero(k, 3);

                  AIni.WriteString(sSecao, 'cnpjOpPortuario', cnpjOpPortuario);
                end;
              end;
            end;
          end;

          for j := 0 to basesAquis.Count -1 do
          begin
            with basesAquis.Items[j] do
            begin
              sSecao := 'basesAquis' + IntToStrZero(I, 4) + IntToStrZero(j, 1);

              AIni.WriteInteger(sSecao, 'indAquis',  indAquis);
              AIni.WriteFloat(sSecao, 'vlrAquis',    vlrAquis);
              AIni.WriteFloat(sSecao, 'vrCPDescPR',  vrCPDescPR);
              AIni.WriteFloat(sSecao, 'vrCPNRet',    vrCPNRet);
              AIni.WriteFloat(sSecao, 'vrRatNRet',   vrRatNRet);
              AIni.WriteFloat(sSecao, 'vrSenarNRet', vrSenarNRet);
              AIni.WriteFloat(sSecao, 'vrCPCalcPR',  vrCPCalcPR);
              AIni.WriteFloat(sSecao, 'vrRatDescPR', vrRatDescPR);
              AIni.WriteFloat(sSecao, 'vrRatCalcPR', vrRatCalcPR);
              AIni.WriteFloat(sSecao, 'vrSenarDesc', vrSenarDesc);
              AIni.WriteFloat(sSecao, 'vrSenarCalc', vrSenarCalc);
            end;
           end;

          for j := 0 to basesComerc.Count -1 do
          begin
            with basesComerc.Items[j] do
            begin
              sSecao := 'basesComerc' + IntToStrZero(I, 4) + IntToStrZero(j, 1);

              AIni.WriteInteger(sSecao, 'indComerc', indComerc);
              AIni.WriteFloat(sSecao, 'vrBcComPR',   vrBcComPr);
              AIni.WriteFloat(sSecao, 'vrCPSusp',    vrCPSusp);
              AIni.WriteFloat(sSecao, 'vrRatSusp',   vrRatSusp);
              AIni.WriteFloat(sSecao, 'vrSenarSusp', vrSenarSusp);
            end;
           end;

          for j := 0 to infoCREstab.Count -1 do
          begin
            with infoCREstab.Items[j] do
            begin
              sSecao := 'infoCREstab' + IntToStrZero(I, 4) + IntToStrZero(j, 2);

              AIni.WriteInteger(sSecao, 'tpCR',   tpCR);
              AIni.WriteFloat(sSecao, 'vrCR',     vrCR);
              AIni.WriteFloat(sSecao, 'vrSuspCR', vrSuspCR);
            end;
           end;

        end;
      end;

      for i := 0 to infoCS.infoCRContrib.Count -1 do
      begin
        sSecao := 'infoCRContrib' + IntToStrZero(I, 2);

        AIni.WriteString(sSecao, 'tpCR',    infoCS.infoCRContrib.Items[i].tpCR);
        AIni.WriteFloat(sSecao, 'vrCR',     infoCS.infoCRContrib.Items[i].vrCR);
        AIni.WriteFloat(sSecao, 'vrCRSusp', infoCS.infoCRContrib.Items[i].vrCRSusp);
      end;
    end;
  finally
    AIni.Free;
  end;
end;

end.
