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
|* 29/02/2015: Guilherme Costa
|*  - n�o estava sendo gerada a tag "tpProc"
******************************************************************************}

{$I ACBr.inc}

unit pcesRetEnvioLote;

interface

uses
  SysUtils, Classes,
  pcnAuxiliar, pcnConversao, pcnLeitor,
  pcesCommon, pcesRetornoClass, pcesConversaoeSocial;

type
  TRetEnvioLote = class(TObject)
  private
    FLeitor: TLeitor;
    FIdeEmpregador: TIdeEmpregador;
    FIdeTransmissor: TIdeTransmissor;
    FStatus: TStatus;
    FDadosRecLote: TDadosRecepcaoLote;
  public
    constructor Create;
    destructor Destroy; override;

    function LerXml: boolean;
    property Leitor: TLeitor read FLeitor write FLeitor;
    property IdeEmpregador: TIdeEmpregador read FIdeEmpregador write FIdeEmpregador;
    property IdeTransmissor: TIdeTransmissor read FIdeTransmissor write FIdeTransmissor;
    property Status: TStatus read FStatus write FStatus;
    property DadosRecLote: TDadosRecepcaoLote read FDadosRecLote write FDadosRecLote;
  end;

implementation

{ TRetEnvioLote }

constructor TRetEnvioLote.Create;
begin
  inherited Create;

  FLeitor         := TLeitor.Create;
  FIdeEmpregador  := TIdeEmpregador.Create;
  FIdeTransmissor := TIdeTransmissor.Create;
  FStatus         := TStatus.Create;
  FDadosRecLote   := TDadosRecepcaoLote.Create;
end;

destructor TRetEnvioLote.Destroy;
begin
  FLeitor.Free;
  FIdeEmpregador.Free;
  FIdeTransmissor.Free;
  FStatus.Free;
  FDadosRecLote.Free;

  inherited;
end;

function TRetEnvioLote.LerXml: boolean;
var
  ok: boolean;
  i: Integer;
begin
  Result := False;
  try
    Leitor.Grupo := Leitor.Arquivo;
    if leitor.rExtrai(1, 'retornoEnvioLoteEventos') <> '' then
    begin
      if leitor.rExtrai(2, 'ideEmpregador') <> '' then
      begin
        IdeEmpregador.TpInsc := eSStrToTpInscricao(Ok, FLeitor.rCampo(tcStr, 'tpInsc'));
        IdeEmpregador.NrInsc := FLeitor.rCampo(tcStr, 'nrInsc');
      end;

      if leitor.rExtrai(2, 'ideTransmissor') <> '' then
      begin
        IdeTransmissor.TpInsc := eSStrToTpInscricao(Ok, FLeitor.rCampo(tcStr, 'tpInsc'));
        IdeTransmissor.NrInsc := FLeitor.rCampo(tcStr, 'nrInsc');
      end;

      if leitor.rExtrai(2, 'status') <> '' then
      begin
        Status.cdResposta   := Leitor.rCampo(tcInt, 'cdResposta');
        Status.descResposta := Leitor.rCampo(tcStr, 'descResposta');

        if leitor.rExtrai(3, 'ocorrencias') <> '' then
        begin
          i := 0;
          while Leitor.rExtrai(4, 'ocorrencia', '', i + 1) <> '' do
          begin
            Status.Ocorrencias.Add;
            Status.Ocorrencias.Items[i].Codigo      := FLeitor.rCampo(tcInt, 'codigo');
            Status.Ocorrencias.Items[i].Descricao   := FLeitor.rCampo(tcStr, 'descricao');
            Status.Ocorrencias.Items[i].Tipo        := FLeitor.rCampo(tcInt, 'tipo');
            Status.Ocorrencias.Items[i].Localizacao := FLeitor.rCampo(tcStr, 'localizacao');
            inc(i);
          end;
        end;

      end;

      if leitor.rExtrai(2, 'dadosRecepcaoLote') <> '' then
      begin
        dadosRecLote.dhRecepcao          := Leitor.rCampo(tcDatHor, 'dhRecepcao');
        dadosRecLote.versaoAplicRecepcao := FLeitor.rCampo(tcStr, 'versaoAplicativoRecepcao');
        dadosRecLote.Protocolo           := FLeitor.rCampo(tcStr, 'protocoloEnvio');
      end;

      Result := True;
    end;
  except
    Result := False;
  end;
end;

end.

