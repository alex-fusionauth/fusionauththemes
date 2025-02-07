import { auth } from '@/auth';
import { Avatar, AvatarFallback } from '@/components/ui/avatar';
import { Badge } from '@/components/ui/badge';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { decodeJwt } from 'jose';
import { Clock, Key, Shield, User } from 'lucide-react';

export default async function CoolUserPage() {
  const session = await auth();
  if (!session?.access_token || !session?.id_token) {
    return <>Missing Auth Token, turn around you should never be here!</>;
  }
  // biome-ignore lint/suspicious/noExplicitAny: <explanation>
  const access_token: any = decodeJwt(session?.access_token);
  // biome-ignore lint/suspicious/noExplicitAny: <explanation>
  const user: any = decodeJwt(session?.id_token);
  return (
    <div className="h-full  text-white p-4 mt-16 overflow-hidden">
      <Card className="max-w-3xl mx-auto bg-[#132828] border-[#00FFD1]/20">
        <CardHeader>
          <CardTitle className="text-2xl font-bold text-center text-[#00FFD1]">
            User Profile
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="flex flex-col items-center mb-6">
            <Avatar className="w-16 h-16 mb-4 bg-[#00FFD1]/20 border-2 border-[#00FFD1]/40">
              <AvatarFallback className="text-xl ">
                {user.email[0].toUpperCase()}
              </AvatarFallback>
            </Avatar>
            <h2 className="text-xl font-semibold text-[#00FFD1]">
              {user.email}
            </h2>
            <Badge className="mt-2 bg-[#00FFD1]/20 text-[#00FFD1] hover:bg-[#00FFD1]/30">
              {user.email_verified ? 'Verified' : 'Unverified'}
            </Badge>
          </div>

          <Tabs defaultValue="user" className="w-full">
            <TabsList className="grid w-full grid-cols-2 bg-[#0D1F1F]">
              <TabsTrigger
                value="user"
                className="data-[state=active]:bg-[#00FFD1]/20 data-[state=active]:text-[#00FFD1]"
              >
                User Info
              </TabsTrigger>
              <TabsTrigger
                value="token"
                className="data-[state=active]:bg-[#00FFD1]/20 data-[state=active]:text-[#00FFD1]"
              >
                Token Info
              </TabsTrigger>
            </TabsList>
            <TabsContent value="user">
              <Card className="bg-[#0D1F1F] border-[#00FFD1]/20">
                <CardHeader>
                  <CardTitle className="flex items-center text-lg text-[#00FFD1]">
                    <User className="mr-2 h-5 w-5" /> User Details
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <dl className="grid grid-cols-3 gap-3 text-sm">
                    {Object.entries(user).map(([key, value]) => (
                      <div key={key} className="col-span-2 sm:col-span-1">
                        <dt className="font-medium text-[#00FFD1]/70">{key}</dt>
                        <dd className="mt-1 text-white">{String(value)}</dd>
                      </div>
                    ))}
                  </dl>
                </CardContent>
              </Card>
            </TabsContent>
            <TabsContent value="token">
              <Card className="bg-[#0D1F1F] border-[#00FFD1]/20">
                <CardHeader>
                  <CardTitle className="flex items-center text-lg text-[#00FFD1]">
                    <Key className="mr-2 h-5 w-5" /> Access Token
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <dl className="grid grid-cols-3 gap-3 text-sm">
                    {Object.entries(access_token).map(([key, value]) => (
                      <div key={key} className="col-span-2 sm:col-span-1">
                        <dt className="font-medium text-[#00FFD1]/70">{key}</dt>
                        <dd className="mt-1 text-white">
                          {Array.isArray(value)
                            ? value.join(', ') || 'None'
                            : String(value)}
                        </dd>
                      </div>
                    ))}
                  </dl>
                </CardContent>
              </Card>
            </TabsContent>
          </Tabs>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4">
            <Card className="bg-[#0D1F1F] border-[#00FFD1]/20">
              <CardHeader className="pb-2">
                <CardTitle className="flex items-center text-sm text-[#00FFD1]">
                  <Shield className="mr-2 h-4 w-4" /> Authentication
                </CardTitle>
              </CardHeader>
              <CardContent className="text-sm">
                <p className="flex gap-2">
                  <span className="text-[#00FFD1]/70">Type:</span>
                  <span className="text-white">{user.authenticationType}</span>
                </p>
                <p className="flex gap-2">
                  <span className="text-[#00FFD1]/70">Scope:</span>
                  <span className="text-white">{user.scope}</span>
                </p>
              </CardContent>
            </Card>
            <Card className="bg-[#0D1F1F] border-[#00FFD1]/20">
              <CardHeader className="pb-2">
                <CardTitle className="flex items-center text-sm text-[#00FFD1]">
                  <Clock className="mr-2 h-4 w-4" /> Timestamps
                </CardTitle>
              </CardHeader>
              <CardContent className="text-sm">
                <p className="flex gap-2">
                  <span className="text-[#00FFD1]/70">Issued:</span>
                  <span className="text-white">
                    {new Date(user.iat * 1000).toLocaleString()}
                  </span>
                </p>
                <p className="flex gap-2">
                  <span className="text-[#00FFD1]/70">Expires:</span>
                  <span className="text-white">
                    {new Date(user.exp * 1000).toLocaleString()}
                  </span>
                </p>
              </CardContent>
            </Card>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
