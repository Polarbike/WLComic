//
//  UserPolicyViewController.m
//  QuickAnimation
//
//  Created by Weilian on 04/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "UserPolicyViewController.h"

@interface UserPolicyViewController ()


@property (weak, nonatomic) IBOutlet UITextView *policyTextView;

@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@end

@implementation UserPolicyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //不添加这个方法会从最上面计算布局，不会从导航栏下计算布局
    self.navigationController.navigationBar.translucent = NO;
    self.policyTextView.text = @"小漫画App用户协议\n请仔细阅读本协议，小漫画App平台将依据以下条件和条款为您提供服务。欢迎阅读小漫画App平台用户协议(下称“本协议”)。本协议阐述之条款和条件适用于您使用小漫画App平台所提供的各种工具和服务(下称“服务”)。\n1．服务条款的确认小漫画App平台根据本服务条款及对该条款的修改向用户提供服务。本服务条款具有合同法上的法律效力。 如果您对协议的任何条款表示异议，您可以选择不注册，一旦您点选“注册”并通过注册程序，即表示您自愿接受本协议之所有条款，并已成为小漫画App平台的注册用户。用户在使用小漫画App平台的同时，同意接受小漫画App平台注册用户服务提供的各类信息服务。小漫画有权根据互联网的发展和中华人民共和国有关法律、法规的变化，不断地完善服务质量并依此修改本用户协议条款。用户的权利以及义务的表述，均以最新的服务条款为准。服务条款一旦发生变动，将会在重要页面上提示修改内容。如用户仍继续在服务期内使用该软件即视为自动接受服务条款的变动。小漫画App平台的注册用户承诺遵守法律法规、社会主义制度、国家利益、公民合法权益、公共秩序、社会道德风尚和信息真实性等七条底线。\n小漫画App平台的注册用户承诺其注册的互联网账号名称不含以下情况：\n违反宪法或法律法规规定的；\n反危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；\n损害国家荣誉和利益的，损害公共利益的；\n煽动民族仇恨、民族歧视，破坏民族团结的；\n破坏国家宗教政策，宣扬邪教和封建迷信的；\n散布谣言，扰乱社会秩序，破坏社会稳定的；\n散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的；\n侮辱或者诽谤他人，侵害他人合法权益的；\n含有法律、行政法规禁止的其他内容的。\n2．服务内容及修改、中断、终止\n2.1 小漫画App平台服务的具体内容由本平台根据实际情况提供，并对所提供之服务拥有最终解释权。\n2.2 小漫画App平台仅向其注册用户提供相关服务，与相关服务有关的设备（如个人电脑、手机、及其他与接入互联网或移动网有关的装置）及所需的费用（如为接入互联网而支付的电话费及上网费、为使用移动网而支付的手机费）均由注册用户自行负担。\n2.3 鉴于网络服务的特殊性，用户同意小漫画App平台有权不经事先通知，随时变更、中断或终止部分或全部的网络服务（包括收费网络服务）。小漫画App平台不担保网络服务不会中断，对网络服务的及时性、安全性、准确性也都不作担保。\n2.4 小漫画App平台需要定期或不定期地对提供网络服务的平台或相关的设备进行检修或者维护，如因此类情况而造成网络服务（包括收费网络服务）在合理时间内的中断，小漫画App平台无需为此承担任何责任。小漫画App平台保留不经事先通知为维修保养、升级或其它目的暂停全部或部分的网络服务的权利。\n2.5 用户明确同意其使用小漫画App平台网络服务所存在的风险将完全由其自己承担。用户理解并接受下载或通过小漫画App平台服务而链接及得到的资讯、产品及服务均系小漫画App平台自动搜录，小漫画App平台对其合法性概不负责，亦不承担任何法律责任，用户自行承担风险，小漫画App平台不做任何形式的保证，不保证搜索结果满足用户的要求，不保证搜索服务不中断，对搜索结果的安全性、正确性、及时性、合法性均不做担保。\n2.6小漫画App平台有权于任何时间暂时或永久修改或终止本服务（或其任何部分），而无论其通知与否，小漫画App平台对用户和任何第三人均无需承担任何责任。\n2.7 您同意小漫画App平台得基于其自行之考虑，因任何理由，包含但不限于长时间未使用，或小漫画App平台认为您已经违反本服务协议的文字及精神，终止您的密码、帐号或本服务之使用（或服务之任何部分），并将您在本服务内任何内容加以移除并删除。您同意依本服务协议任何规定提供之服务，无需进行事先通知即可中断或终止，您承认并同意，小漫画App平台可立即关闭或删除您的帐号及您帐号中所有相关信息及文件，或禁止继续使用前述文件或本服务。\n此外，您同意若本服务之使用被中断或终止或您的帐号及相关信息和文件被关闭或删除，小漫画App平台对您或任何第三人均不承担任何责任。\n3．注册用户帐号及密码\n3.1 用户注册注册用户成功后，小漫画App平台将给予每个注册用户一个帐号及相应的密码，该帐号和密码由用户负责保管；用户应当对以其用户帐号进行的所有活动和事件负法律责任。\n3.2 因黑客行为或注册用户保管疏忽致使帐号、密码被他人非法使用的，本公司不承担任何责任。如您发现任何非法使用注册用户帐号或安全漏洞的情况，请立即与本公司联系。\n4. 注册信息和隐私保护\n4.1 小漫画App平台帐号（即小漫画漫画App平台用户ID）的所有权归小漫画App平台，用户完成注册申请手续后，获得小漫画App平台帐号的使用权。用户应提供及时、详尽及准确的个人资料，并不断更新注册资料，符合及时、详尽准确的要求。所有原始键入的资料将作为注册资料。如果因用户注册信息不真实而引起的问题及其产生的后果，小漫画App平台不负任何责任。\n4.2 用户不得将其帐号、密码转让或出借予他人使用。如发现其帐号遭他人非法使用，应立即通知快看漫画App平台。\n4.3 快看漫画App平台不对外公开或向第三方提供单个用户的注册资料，除非：\n事先获得用户的明确授权；\n只有透露你的个人资料，才能提供你所要求的产品和服务；\n根据有关的法律法规要求；\n按照相关政府主管部门的要求；\n为维护快看漫画App平台的合法权益。\n4.4 在您注册小漫画App平台帐户，使用小漫画App平台产品或服务，或访问小漫画App平台网页时，小漫画App平台会收集您的个人身份识别资料，并会将这些资料用于：改进为您提供的服务及网页内容。\n5.10本协议的最终解释权归小漫画App平台所有。";
    
    //设置导航上的返回按钮
    UIImage *leftImage = [[UIImage imageNamed:@"ic_nav_second_back_normal_17x17_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:leftImage style:(UIBarButtonItemStyleDone) target:self action:@selector(backButtonClickAction)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
}

#pragma mark -- 自定义返回按钮点击方法
- (void)backButtonClickAction {
    //返回视图
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
}


- (IBAction)makeSureClick:(id)sender {
    
    
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    
   if(viewcontrollers.count>1) {
        
   if([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
       
       //push方式
       [self.navigationController popViewControllerAnimated:YES];
       
    }else{
        
        //present方式
        [self dismissViewControllerAnimated:YES completion:nil];

        }
   
   }else{
       
       //present方式
       [self dismissViewControllerAnimated:YES completion:nil];
   }
//    if (self.beingPresented) {
//
//        [self dismissViewControllerAnimated:YES completion:nil];
//
//    }else{
//
//        [self.navigationController popViewControllerAnimated:YES];
//    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
