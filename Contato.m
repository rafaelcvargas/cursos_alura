//
//  Contato.m
//  ContatosIP67
//
//  Created by ios8207 on 2/5/19.
//  Copyright © 2019 vargas. All rights reserved.
//

#import "Contato.h"

@implementation Contato

-(NSString *)description{
    return [NSString stringWithFormat:@"Nome: %@, Telefone: %@, Endereco: %@, Site: %@",self.nome, self.telefone, self.endereco, self.site];
}

@end
