import { Injectable, OnModuleInit, OnModuleDestroy } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService
  extends PrismaClient
  implements OnModuleInit, OnModuleDestroy
{
  async onModuleInit() {
    // Conecta no banco quando a aplicação sobe
    await this.$connect();
  }

  async onModuleDestroy() {
    // Desconecta ao finalizar a aplicação
    await this.$disconnect();
  }
}