From 942a712a342c18d58ceb610ff818e4362deea5ca Mon Sep 17 00:00:00 2001
From: gongzi miao <miaogongzi0227@gmail.com>
Date: Mon, 19 Jan 2026 00:43:55 +0800
Subject: [PATCH] dnsmasq: bump release to 2.92

bump dnsmasq to latest 2.92

updated 200-ubus_dns.patch
no changes to 100-remove-old-runtime-kernel-support.patch
all remaining patches not required

Changelog for version 2.92 https://thekelleys.org.uk/dnsmasq/CHANGELOG

Signed-off-by: gongzi miao <miaogongzi0227@gmail.com>
---
 package/network/services/dnsmasq/Makefile     |  6 +-
 ...00-remove-old-runtime-kernel-support.patch | 25 ++++----
 .../dnsmasq/patches/200-ubus_dns.patch        | 60 ++++++++++---------
 3 files changed, 47 insertions(+), 44 deletions(-)

diff --git a/package/network/services/dnsmasq/Makefile b/package/network/services/dnsmasq/Makefile
index 480f1dfc2b029d..5872a5344971ac 100644
--- a/package/network/services/dnsmasq/Makefile
+++ b/package/network/services/dnsmasq/Makefile
@@ -8,13 +8,13 @@
 include $(TOPDIR)/rules.mk
 
 PKG_NAME:=dnsmasq
-PKG_UPSTREAM_VERSION:=2.91
+PKG_UPSTREAM_VERSION:=2.92
 PKG_VERSION:=$(subst test,~~test,$(subst rc,~rc,$(PKG_UPSTREAM_VERSION)))
-PKG_RELEASE:=2
+PKG_RELEASE:=1
 
 PKG_SOURCE:=$(PKG_NAME)-$(PKG_UPSTREAM_VERSION).tar.xz
 PKG_SOURCE_URL:=https://thekelleys.org.uk/dnsmasq/
-PKG_HASH:=f622682848b33677adb2b6ad08264618a2ae0a01da486a93fd8cd91186b3d153
+PKG_HASH:=4bf50c2c1018f9fbc26037df51b90ecea0cb73d46162846763b92df0d6c3a458
 
 PKG_LICENSE:=GPL-2.0
 PKG_LICENSE_FILES:=COPYING
diff --git a/package/network/services/dnsmasq/patches/100-remove-old-runtime-kernel-support.patch b/package/network/services/dnsmasq/patches/100-remove-old-runtime-kernel-support.patch
index 26c1b463b94c7e..feda43e8e813ca 100644
--- a/package/network/services/dnsmasq/patches/100-remove-old-runtime-kernel-support.patch
+++ b/package/network/services/dnsmasq/patches/100-remove-old-runtime-kernel-support.patch
@@ -13,7 +13,7 @@ Signed-off-by: Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
 
 --- a/src/dnsmasq.c
 +++ b/src/dnsmasq.c
-@@ -105,10 +105,6 @@ int main (int argc, char **argv)
+@@ -114,10 +114,6 @@ int main (int argc, char **argv)
    
    read_opts(argc, argv, compile_opts);
   
@@ -26,16 +26,16 @@ Signed-off-by: Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
  
 --- a/src/dnsmasq.h
 +++ b/src/dnsmasq.h
-@@ -1277,7 +1277,7 @@ extern struct daemon {
+@@ -1298,7 +1298,7 @@ extern struct daemon {
    int inotifyfd;
  #endif
  #if defined(HAVE_LINUX_NETWORK)
 -  int netlinkfd, kernel_version;
-+  int netlinkfd;
++  int int netlinkfd;
  #elif defined(HAVE_BSD_NETWORK)
    int dhcp_raw_fd, dhcp_icmp_fd, routefd;
  #endif
-@@ -1491,9 +1491,6 @@ int read_write(int fd, unsigned char *pa
+@@ -1519,9 +1519,6 @@ int read_write(int fd, unsigned char *packet, int size, int rw);
  void close_fds(long max_fd, int spare1, int spare2, int spare3);
  int wildcard_match(const char* wildcard, const char* match);
  int wildcard_matchn(const char* wildcard, const char* match, int num);
@@ -56,7 +56,7 @@ Signed-off-by: Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
  static char *buffer;
  
  static inline void add_attr(struct nlmsghdr *nlh, uint16_t type, size_t len, const void *data)
-@@ -85,12 +85,7 @@ static inline void add_attr(struct nlmsg
+@@ -85,12 +85,7 @@ static inline void add_attr(struct nlmsghdr *nlh, uint16_t type, size_t len, con
  
  void ipset_init(void)
  {
@@ -66,11 +66,11 @@ Signed-off-by: Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
 -    return;
 -  
 -  if (!old_kernel && 
-+  if (
++  if ( 
        (buffer = safe_malloc(BUFF_SZ)) &&
        (ipset_sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_NETFILTER)) != -1 &&
        (bind(ipset_sock, (struct sockaddr *)&snl, sizeof(snl)) != -1))
-@@ -147,65 +142,14 @@ static int new_add_to_ipset(const char *
+@@ -147,65 +142,14 @@ static int new_add_to_ipset(const char *setname, const union all_addr *ipaddr, i
    return errno == 0 ? 0 : -1;
  }
  
@@ -133,18 +133,17 @@ Signed-off-by: Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
 -  
 -  if (ret != -1) 
 -    ret = old_kernel ? old_add_to_ipset(setname, ipaddr, remove) : new_add_to_ipset(setname, ipaddr, af, remove);
-+
-+  ret = new_add_to_ipset(setname, ipaddr, af, remove);
++    
++ret = new_add_to_ipset(setname, ipaddr, af, remove);
  
    if (ret == -1)
       my_syslog(LOG_ERR, _("failed to update ipset %s: %s"), setname, strerror(errno));
 --- a/src/util.c
 +++ b/src/util.c
-@@ -866,22 +866,3 @@ int wildcard_matchn(const char* wildcard
- 
+@@ -931,21 +931,3 @@ int wildcard_matchn(const char* wildcard, const char* match, int num)
    return (!num) || (*wildcard == *match);
  }
--
+ 
 -#ifdef HAVE_LINUX_NETWORK
 -int kernel_version(void)
 -{
@@ -162,4 +161,4 @@ Signed-off-by: Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
 -  split = strtok(NULL, ".");
 -  return version * 256 + (split ? atoi(split) : 0);
 -}
--#endif
+-#endif
\ No newline at end of file
diff --git a/package/network/services/dnsmasq/patches/200-ubus_dns.patch b/package/network/services/dnsmasq/patches/200-ubus_dns.patch
index a1a668818ea433..7481bcc8d05630 100644
--- a/package/network/services/dnsmasq/patches/200-ubus_dns.patch
+++ b/package/network/services/dnsmasq/patches/200-ubus_dns.patch
@@ -1,6 +1,6 @@
 --- a/src/dnsmasq.c
 +++ b/src/dnsmasq.c
-@@ -2097,6 +2097,10 @@
+@@ -2123,6 +2123,10 @@ static void do_tcp_connection(struct listener *listener, time_t now, int slot)
        daemon->pipe_to_parent = pipefd[1];
      }
  
@@ -13,7 +13,7 @@
       Reset that here. */
 --- a/src/dnsmasq.h
 +++ b/src/dnsmasq.h
-@@ -1670,14 +1670,26 @@ void emit_dbus_signal(int action, struct
+@@ -1722,14 +1722,26 @@ void emit_dbus_signal(int action, struct dhcp_lease *lease, char *hostname);
  
  /* ubus.c */
  #ifdef HAVE_UBUS
@@ -42,7 +42,7 @@
  /* ipset.c */
 --- a/src/forward.c
 +++ b/src/forward.c
-@@ -803,7 +803,7 @@ static size_t process_reply(struct dns_h
+@@ -803,7 +803,7 @@ static size_t process_reply(struct dns_header *header, time_t now, struct server
  	  cache_secure = 0;
  	}
        
@@ -50,25 +50,26 @@
 +      if ((daemon->doctors || ubus_dns_notify_has_subscribers()) && do_doctor(header, n, daemon->namebuff))
  	cache_secure = 0;
        
-       /* check_for_bogus_wildcard() does it's own caching, so
+       /* check_for_bogus_wildcard() does its own caching, so
 --- a/src/rfc1035.c
 +++ b/src/rfc1035.c
-@@ -13,8 +13,10 @@
+@@ -13,9 +13,10 @@
     You should have received a copy of the GNU General Public License
     along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 -
  #include "dnsmasq.h"
+-
 +#ifdef HAVE_UBUS
 +#include <libubox/blobmsg.h>
 +#endif
- 
- int extract_name(struct dns_header *header, size_t plen, unsigned char **pp, 
- 		 char *name, int isExtract, int extrabytes)
-@@ -384,10 +386,65 @@ static int private_net6(struct in6_addr
+ /* EXTR_NAME_EXTRACT -> extract name
+    EXTR_NAME_COMPARE -> compare name, case insensitive
+    EXTR_NAME_NOCASE -> compare name, case sensitive
+@@ -443,11 +444,65 @@ int private_net6(struct in6_addr *a, int ban_localhost)
+     ((unsigned char *)a)[0] == 0xfd ||   /* RFC 6303 4.4 */
      ((u32 *)a)[0] == htonl(0x20010db8); /* RFC 6303 4.6 */
  }
- 
 +#ifdef HAVE_UBUS
 +static void ubus_dns_doctor_cb(struct blob_attr *msg, void *priv)
 +{
@@ -123,7 +124,7 @@
 +	return 0;
 +}
 +#endif
-+
+ 
  int do_doctor(struct dns_header *header, size_t qlen, char *namebuff)
  {
    unsigned char *p;
@@ -132,7 +133,7 @@
    int done = 0;
    
    if (!(p = skip_questions(header, qlen)))
-@@ -404,7 +461,7 @@ int do_doctor(struct dns_header *header,
+@@ -464,7 +519,7 @@ int do_doctor(struct dns_header *header, size_t qlen, char *namebuff)
        
        GETSHORT(qtype, p); 
        GETSHORT(qclass, p);
@@ -141,20 +142,20 @@
        GETSHORT(rdlen, p);
        
        if (qclass == C_IN && qtype == T_A)
-@@ -415,6 +472,9 @@ int do_doctor(struct dns_header *header,
+@@ -474,6 +529,8 @@ int do_doctor(struct dns_header *header, size_t qlen, char *namebuff)
+ 	  
  	  if (!CHECK_LEN(header, p, qlen, INADDRSZ))
  	    return done;
- 	  
 +	  if (ubus_dns_doctor(daemon->namebuff, ttl, p, AF_INET))
 +	    header->hb3 &= ~HB3_AA;
-+
+ 	  
  	  /* alignment */
  	  memcpy(&addr.addr4, p, INADDRSZ);
- 	  
-@@ -444,6 +504,14 @@ int do_doctor(struct dns_header *header,
+@@ -504,7 +561,14 @@ int do_doctor(struct dns_header *header, size_t qlen, char *namebuff)
  	      break;
  	    }
  	}
+-      
 +      else if (qclass == C_IN && qtype == T_AAAA)
 +        {
 +	  if (!CHECK_LEN(header, p, qlen, IN6ADDRSZ))
@@ -162,13 +163,13 @@
 +
 +	  if (ubus_dns_doctor(daemon->namebuff, ttl, p, AF_INET6))
 +	    header->hb3 &= ~HB3_AA;
-+	}
-       
++	}      
        if (!ADD_RDLEN(header, p, qlen, rdlen))
  	 return done; /* bad packet */
+     }
 --- a/src/ubus.c
 +++ b/src/ubus.c
-@@ -72,6 +72,13 @@ static struct ubus_object ubus_object =
+@@ -72,6 +72,13 @@ static struct ubus_object ubus_object = {
    .subscribe_cb = ubus_subscribe_cb,
  };
  
@@ -182,7 +183,7 @@
  static void ubus_subscribe_cb(struct ubus_context *ctx, struct ubus_object *obj)
  {
    (void)ctx;
-@@ -105,13 +112,21 @@ static void ubus_disconnect_cb(struct ub
+@@ -105,13 +112,20 @@ static void ubus_disconnect_cb(struct ubus_context *ubus)
  char *ubus_init()
  {
    struct ubus_context *ubus = NULL;
@@ -191,23 +192,24 @@
  
    if (!(ubus = ubus_connect(NULL)))
      return NULL;
-   
+-  
++
 +  dns_name = whine_malloc(strlen(daemon->ubus_name) + 5);
 +  sprintf(dns_name, "%s.dns", daemon->ubus_name);
 +
    ubus_object.name = daemon->ubus_name;
 +  ubus_dns_object.name = dns_name;
-+
    ret = ubus_add_object(ubus, &ubus_object);
 +  if (!ret)
 +    ret = ubus_add_object(ubus, &ubus_dns_object);
    if (ret)
      {
        ubus_destroy(ubus);
-@@ -181,6 +196,17 @@ void check_ubus_listeners()
+@@ -181,7 +195,18 @@ void check_ubus_listeners()
        } \
    } while (0)
  
+-static int ubus_handle_metrics(struct ubus_context *ctx, struct ubus_object *obj,
 +void drop_ubus_listeners()
 +{
 +  struct ubus_context *ubus = (struct ubus_context *)daemon->ubus;
@@ -219,13 +221,15 @@
 +  daemon->ubus = NULL;
 +}
 +
- static int ubus_handle_metrics(struct ubus_context *ctx, struct ubus_object *obj,
++  static int ubus_handle_metrics(struct ubus_context *ctx, struct ubus_object *obj,
  			       struct ubus_request_data *req, const char *method,
  			       struct blob_attr *msg)
-@@ -328,6 +354,53 @@ fail:
+ {
+@@ -333,7 +358,54 @@ static int ubus_handle_set_connmark_allowlist(struct ubus_context *ctx, struct u
        } \
    } while (0)
  
+-void ubus_event_bcast(const char *type, const char *mac, const char *ip, const char *name, const char *interface)
 +int ubus_dns_notify_has_subscribers(void)
 +{
 +	return (daemon->ubus && ubus_dns_object.has_subscribers);
@@ -273,6 +277,6 @@
 +	return ubus_complete_request(ubus, &dreq.req.req, 100);
 +}
 +
- void ubus_event_bcast(const char *type, const char *mac, const char *ip, const char *name, const char *interface)
++  void ubus_event_bcast(const char *type, const char *mac, const char *ip, const char *name, const char *interface)
  {
-   struct ubus_context *ubus = (struct ubus_context *)daemon->ubus;
+   struct ubus_context *ubus = (struct ubus_context *)daemon->ubus;
\ No newline at end of file
