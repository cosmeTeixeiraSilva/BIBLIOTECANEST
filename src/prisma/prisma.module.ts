import { Global, Module } from '@nestjs/common';
import { PrismaService } from './prisma.service';
@Global() // opcional -> deixa disponível em toda a aplicação
@Module({
  providers: [PrismaService],
  exports: [PrismaService], // exporta para outros módulos
})
export class PrismaModule {}
