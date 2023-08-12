#include %A_ScriptDir%\src\FindText.ahk
#include %A_ScriptDir%\variaveis.ahk


BuscarItem(Imagem){
	CoordMode Screen
	ImageSearch,  PosX, PosY, 0, 0,  %A_ScreenWidth%, %A_ScreenHeight%, *50 %A_ScriptDir%\src\images\%Imagem%.PNG
	if (ErrorLevel = 2){
		ExitApp
		return
	}
	else if (ErrorLevel = 1){
		ExitApp
		return
	}
	else{
		Pos := Array(PosX, PosY)
		return Pos
	}
}

Clique(Pos){
	PosX := Pos[1]
	PosY := Pos[2]
	Click %PosX% %PosY%
}

CliqueImagem(Imagem){
	Item := BuscarItem(Imagem)
	if(Item != false) {
		Clique(Item)
		OutputDebug, % "Imagem encontrada: " Imagem
	} Else {
		OutputDebug, % "Imagem não encontrada"
	}
}

AguardarTela(Tela){
	carregou := False
	Loop {
		IfWinExist, %Tela%
			carregou := True

		IfWinNotExist, %Tela%
			Sleep, 1000
	} until carregou = True
}

AguardarImagem(Imagem){
	Loop {
		CoordMode Screen
		ImageSearch,  PosX, PosY, 0, 0,  %A_ScreenWidth%, %A_ScreenHeight%, *50 %A_ScriptDir%\src\images\%Imagem%.PNG
		if (ErrorLevel =  0){
			OutputDebug, % "Aguardando imagem - TRUE " Imagem
			Return True
		} Else {
			OutputDebug, % "Aguardando imagem - FALSE " Imagem
			Sleep, 1000
		}
	}
}

Confirmacao(Imagem){
	achou := False
	Loop, 2
	{
		CoordMode Screen
		ImageSearch,  PosX, PosY, 0, 0,  %A_ScreenWidth%, %A_ScreenHeight%, *50 %A_ScriptDir%\src\images\%Imagem%.PNG
		if (ErrorLevel = 1){
			Sleep, 1000
		}
		else if (ErrorLevel = 2){
			Sleep, 1000
		}
		else {
			achou := True
		}
	}
	return achou
}

CliqueTexto(Texto){
	X:=Y:=""

	if (ok:=FindText(X, Y, 549-150000, 76-150000, 549+150000, 76+150000, 0, 0, Texto)) {
	  FindText().Click(X, Y, "L")
	  OutputDebug, % "CliqueTexto - TRUE " Texto
	  return true
	} else {
		OutputDebug, % "CliqueTexto - FALSE " Texto
		return false
	}
}

AguardarTexto(Texto){
	carregou := False
	Loop{
		if (ok:=FindText(X, Y, 549-150000, 76-150000, 549+150000, 76+150000, 0, 0, Texto))
		{
			carregou := True
		}
	} until carregou = True
}

AguardarTextoSair(Texto){
	carregou := True
	Loop{
		if (ok:=FindText(X, Y, 549-150000, 76-150000, 549+150000, 76+150000, 0, 0, Texto))
		{
			carregou := True
		}
		else {
			carregou := False
		}
	} until carregou := False
}

ConfirmacaoTexto(Texto){
	achou := False
	Loop, 1
	{
		if (ok:=FindText(X, Y, 549-150000, 76-150000, 549+150000, 76+150000, 0, 0, Texto)) {
			achou := True
		} Else {
			Sleep, 1000
		}
	}
	return achou
}

PosicaoTexto(Texto){
	X:=Y:=""

	if (ok:=FindText(X, Y, 549-150000, 76-150000, 549+150000, 76+150000, 0, 0, Texto)) {
		return ok
	}
	else {
		return false
	}
}

DefinirUsuario(){
    global usuarioF
    global usuarioF2
    global usuarioFLabel
    global usuarioF2Label

    dia_atual := SubStr(A_Now, 7, 2)

    if(dia_atual = 1){
        user := usuarioF2
        userLabel := usuarioF2Label
    }
    else {
        user := usuarioF
        userLabel := usuarioFLabel
    }

    definirUsuario := [user, userLabel]

    return definirUsuario
}

Deslogar(){
    OutputDebug, % "Deslogar - Iniciado"
    CliqueImagem("DeslogarControle")
    Sleep, 500
    CliqueImagem("DeslogarSair")
    Sleep, 500
    AguardarImagem("DeslogarOk")
    CliqueImagem("DeslogarOk")
    Sleep, 500
    AguardarImagem("DominioWebLogo")
    CliqueImagem("Informacoes")
}