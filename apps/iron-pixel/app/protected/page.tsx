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
    <div className="min-h-screen bg-gray-900 text-white p-8 mt-16">
      <Card className="bg-gray-800 border-gray-700">
        <CardHeader>
          <CardTitle className="text-3xl font-bold text-center">
            User Profile
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="flex flex-col items-center mb-6">
            <Avatar className="w-24 h-24 mb-4">
              <AvatarFallback className="text-2xl">
                {user?.email[0]?.toUpperCase()}
              </AvatarFallback>
            </Avatar>
            <h2 className="text-2xl font-semibold">{user.email}</h2>
            <Badge variant="secondary" className="mt-2">
              {user.email_verified ? 'Verified' : 'Unverified'}
            </Badge>
          </div>

          <Tabs defaultValue="user" className="w-full">
            <TabsList className="grid w-full grid-cols-2">
              <TabsTrigger value="user">User Info</TabsTrigger>
              <TabsTrigger value="token">Token Info</TabsTrigger>
            </TabsList>
            <TabsContent value="user">
              <Card className="bg-gray-700 border-gray-600">
                <CardHeader>
                  <CardTitle className="flex items-center">
                    <User className="mr-2" /> User Details
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <dl className="grid grid-cols-2 gap-4">
                    {Object.entries(user).map(([key, value]) => (
                      <div key={key} className="col-span-2 sm:col-span-1">
                        <dt className="font-medium text-gray-400">{key}</dt>
                        <dd className="mt-1 text-sm">{String(value)}</dd>
                      </div>
                    ))}
                  </dl>
                </CardContent>
              </Card>
            </TabsContent>
            <TabsContent value="token">
              <Card className="bg-gray-700 border-gray-600">
                <CardHeader>
                  <CardTitle className="flex items-center">
                    <Key className="mr-2" /> Access Token
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <dl className="grid grid-cols-2 gap-4">
                    {Object.entries(access_token).map(([key, value]) => (
                      <div key={key} className="col-span-2 sm:col-span-1">
                        <dt className="font-medium text-gray-400">{key}</dt>
                        <dd className="mt-1 text-sm">
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

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mt-6">
            <Card className="bg-gray-700 border-gray-600">
              <CardHeader>
                <CardTitle className="flex items-center">
                  <Shield className="mr-2" /> Authentication
                </CardTitle>
              </CardHeader>
              <CardContent>
                <p>
                  <strong>Type:</strong> {user.authenticationType}
                </p>
                <p>
                  <strong>Scope:</strong> {user.scope}
                </p>
              </CardContent>
            </Card>
            <Card className="bg-gray-700 border-gray-600">
              <CardHeader>
                <CardTitle className="flex items-center">
                  <Clock className="mr-2" /> Timestamps
                </CardTitle>
              </CardHeader>
              <CardContent>
                <p>
                  <strong>Issued At:</strong>{' '}
                  {new Date(user.iat * 1000).toLocaleString()}
                </p>
                <p>
                  <strong>Expires:</strong>{' '}
                  {new Date(user.exp * 1000).toLocaleString()}
                </p>
                <p>
                  <strong>Auth Time:</strong>{' '}
                  {new Date(user.auth_time * 1000).toLocaleString()}
                </p>
              </CardContent>
            </Card>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
