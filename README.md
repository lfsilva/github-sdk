# github-sdk

SDK do GitHub.

## Pré-requisitos

Ter as seguintes ferramentas instaladas.

#### rbenv

```sh
brew install rbenv
echo 'eval "$(rbenv init -)"' >> ~/.zshrc
```

#### Bunder

```sh
gem install bundler
```

#### Ruby:

```sh
rbenv install 3.1.6
```

## Execução do projeto

#### Gems:

```sh
bundle install
```

#### Variável de ambiente:

No target `Example`, modificar o valor da variável de usuário `API_TOKEN` para o valor do token de autenticação do GitHub, de acordo com a seguinte documentação:

https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens

## Uso

A biblioteca github-sdk está disponível através do [CocoaPods](https://cocoapods.org). Para instalar e usar no seu projeto, adicione a seguinte linha ao `Podfile`:

```ruby
pod 'github-sdk', :git => 'https://github.com/lfsilva/github-sdk.git'
```

## Author

Leandro Fernandes, lfsilva@me.com
